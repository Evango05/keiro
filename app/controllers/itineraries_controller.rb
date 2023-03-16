require 'uri'
require 'open-uri'

class ItinerariesController < ApplicationController
  def index
    @itineraries = Itinerary.all
    @maps = ["itineraries/map1.png", "itineraries/map2.png", "itineraries/map3.png", "itineraries/map4.png", "itineraries/map5.png", "itineraries/map6.png", "itineraries/map8.png"]
  end

  def new
    @itinerary = Itinerary.new
    @hotspots = Hotspot.all
  end

  def create
    @itinerary = Itinerary.new({selected_hotspot_ids: @selected_hotspot_ids })

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
    # sleep 3
    @itinerary = Itinerary.find(params[:id])
    @hotspot_instances = Hotspot.where(id: @itinerary.selected_hotspot_ids)
    @markers = @hotspot_instances.geocoded.map do |hotspot|
      {
        lat: hotspot.latitude,
        lng: hotspot.longitude,
        marker_html: render_to_string(partial: "marker")
      }
    end

    @passingcoordinates = Hotspot.as_string(@itinerary)
  end

  def recap
    @itinerary = Itinerary.find(params[:itinerary_id])
    @hotspot_instances = Hotspot.where(id: @itinerary.selected_hotspot_ids)
    @markers = @hotspot_instances.geocoded.map do |hotspot|
      {
        lat: hotspot.latitude,
        lng: hotspot.longitude,
        marker_html: render_to_string(partial: "marker")
      }
    end

    # @passingcoordinates = hotspots_string(@hotspot_instances)
  end

  def navigation
    @itinerary = Itinerary.find(params[:itinerary_id])
    @hotspot_instances = Hotspot.where(id: @itinerary.selected_hotspot_ids)
  end

  private

  def itinerary_params
    params.require(:itinerary).permit(:duration, :length, :elevation, :request_id, :selected_hotspot_ids)
  end
end
