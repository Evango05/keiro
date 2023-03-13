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

    # to fetch stuff from data
    # data["routes"][0]
    # data["uuid"]

    @itinerary.route = data

    @itinerary.length = data["routes"][0]["distance"]

    # Methode pour passer en km avec 2 chiffres après la virgule
    @itinerary.length = @itinerary.length / 1000
    @itinerary.length = @itinerary.length.round(2)

  # Methode pour passer en minutes
    @itinerary.duration = data["routes"][0]["duration"] / 60

    if @itinerary.save
      redirect_to itinerary_path(@itinerary)
    end

  end

  def show
    @itinerary = Itinerary.find(params[:id])
    @hotspot_instances = Hotspot.where(id: @itinerary.selected_hotspot_ids)

    @markers = @hotspot_instances.map do |hotspot|
      {
        lat: hotspot.latitude,
        lng: hotspot.longitude
      }
    end

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
