require 'open-uri'

class RequestsController < ApplicationController
  def new
    @request = Request.new
    @hotspots = Hotspot.all
    @markers = @hotspots.geocoded.map do |hotspot|
      {
        lat: hotspot.latitude,
        lng: hotspot.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { hotspot: hotspot }),
        marker_html: render_to_string(partial: "marker"),
        categories: hotspot.categories
      }
    end
  end

  def create
    @request = Request.new(request_params)
    @request.user = current_user

    @request.category = params[:request][:category]
    @request.category = @request.category.reject(&:empty?)

    @request.longitude = params[:request][:longitude]
    @request.latitude = params[:request][:latitude]


    # no need to create a view for create
    if @request.save
      redirect_to request_path(@request)
    else
      flash[:alert] = "Something went wrong"
    end
  end

  def show
    @request = Request.find(params[:id])
    selected_cats = @request.category
    @categories = Category.all
    hotspots = Hotspot.from_categories(selected_cats)
    @itinerary = Itinerary.create(
      selected_hotspot_ids: hotspots.map(&:id),
      request: @request
    )

    url = direction_url(@itinerary)
    routes_serialized = URI.open(url).read
    data = JSON.parse(routes_serialized)

    # -------- C'est ici que ça se passe on fait directement un update --------- %>

    @itinerary.update(
      route: data,
      length: (data["routes"][0]["distance"] / 1000).round(1),
      duration: data["routes"][0]["duration"] / 130
    )

    if @itinerary.save
      redirect_to @itinerary
    else
      flash[:alert] = "Something went wrong"
    end
  end

  private

  def direction_url(itinerary)
    safe_hotspots_string = CGI.escape Hotspot.as_string(itinerary)
    "https://api.mapbox.com/directions/v5/mapbox/walking/#{safe_hotspots_string}?alternatives=true&geometries=geojson&language=en&overview=simplified&steps=true&access_token=#{ENV['MAPBOX_API_KEY']}"
  end

  def request_params
    params.require(:request).permit(:id, :distance, :longitude, :latitude, :selected_hotspots_id, category: [])
  end

end
