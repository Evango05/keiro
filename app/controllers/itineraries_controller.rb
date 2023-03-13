require 'uri'
require 'open-uri'

class ItinerariesController < ApplicationController
  def index
    @itineraries = Itinerary.all
  end

  def new
    @itinerary = Itinerary.new
    @hotspots = Hotspot.all
  end

  def create
    @itinerary = Itinerary.new(itinerary_params)

    @itinerary.request = Request.find(params[:itinerary][:request_id])

    @hotspot_ids = params[:itinerary][:selected_hotspot_ids]

    @hotspot_ids = @hotspot_ids.split(" ").map(&:to_i)

    hotspots = Hotspot.where(id: @hotspot_ids)

    @itinerary.selected_hotspot_ids = @hotspot_ids

    safe_hotspots_string = CGI.escape hotspots_string(hotspots)

    # Call Mappbox API to get route data

    url = "https://api.mapbox.com/directions/v5/mapbox/walking/#{safe_hotspots_string}?alternatives=true&geometries=geojson&language=en&overview=simplified&steps=true&access_token=#{ENV['MAPBOX_API_KEY']}"
    # url = "https://api.mapbox.com/directions/v5/walking/#{hotspots_string}?access_token=#{ENV['MAPBOX_API_KEY']}"

    routes_serialized = URI.open(url).read

    data = JSON.parse(routes_serialized)
    # return a list of routes

    data["routes"][0]
    data["uuid"]

    @itinerary.route = data


    # # data.routes.first
    # @itinerary.route = data.routes.first # JSON column

    if @itinerary.save
      redirect_to itinerary_path(@itinerary)
    end
    # code stops here: a first instance of itinerary is being saved
    # now send it to mapbox
  end

  def show
    @itinerary = Itinerary.find(params[:id])
    @hotspot_instances = Hotspot.where(id: @itinerary.selected_hotspot_ids)

    # @itinerary.selected_hotspot_ids.each do |hotspot|
    #   @hotspot_instances << Hotspot.find(hotspot.to_i)
    # end

    @markers = @hotspot_instances.map do |hotspot|
      {
        lat: hotspot.latitude,
        lng: hotspot.longitude
      }
    end

    # # j'instancie mon array de coordonnées
    # @passingcoordinates = []
    # # j'y ajoute ma coordonnée de départ
    # @passingcoordinates << [@itinerary.request.longitude, @itinerary.request.latitude]
    # #  je compile
    # @hotspot_instances.each do |hotspot|
    #   @passingcoordinates << [hotspot.longitude, hotspot.latitude]
    # end
    # # j'y ajoute ma coordonnée de fin
    # @passingcoordinates << [@itinerary.request.longitude, @itinerary.request.latitude]
    # # j'interpole le tout au bon format pour la requete API
    # @passingcoordinates = @passingcoordinates.map { |coord| coord.join(",") }.join(";")
    @passingcoordinates = hotspots_string(@hotspot_instances)
  end


  private

  def itinerary_params
    params.require(:itinerary).permit(:duration, :length, :elevation, :request_id, :selected_hotspot_ids)
  end

  def hotspots_string(hotspots)
    # j'instancie mon array de coordonnées
    # passingcoordinates = [[@itinerary.request.longitude, @itinerary.request.latitude]]
    start_point = "#{@itinerary.request.longitude},#{@itinerary.request.latitude};"    #  je compile

    hotspots.reduce(start_point) do |string, hotspot|
      string + "#{hotspot.longitude},#{hotspot.latitude};"
    end + start_point[0...-1]
    # hotspots.each do |hotspot|
    #   passingcoordinates << [hotspot.longitude, hotspot.latitude]
    # end
    # # j'y ajoute ma coordonnée de fin
    # passingcoordinates << [@itinerary.request.longitude, @itinerary.request.latitude]
    # # j'interpole le tout au bon format pour la requete API
    # passingcoordinates = passingcoordinates.map { |coord| coord.join(",") }.join(";")
  end
end
