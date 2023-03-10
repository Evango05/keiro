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

    @request.save
    # no need to create a view for create
    redirect_to request_path(@request)
  end

  def show
    @request = Request.find(params[:id])

    @itinerary = Itinerary.new
    @hotspots = Hotspot.all

    @selected_cat = @request.category
    @categories = Category.all
    array = []

    @selected_cat.each do |cat|
      @categories.each do |category|
        if cat == category.name
          array << Category.find(category.id)
        end
      end
    end

    @selected_hotspot_ids = []
    @selected_hotspots = []

    array.each do |category|
      @selected_hotspot_ids << category.hotspots.ids
    end

    @selected_hotspot_ids = @selected_hotspot_ids.flatten.uniq #uniq ??


    @selected_hotspot_ids.each do |id|
      @hotspots.each do |hotspot|
        if id == hotspot.id
          @selected_hotspots << hotspot
        end
      end
    end

    # @selected_hotspots = @selected_hotspots[0]
    #DEBUG == ici @selected_hotspot_ids fonctionne parfaitement
    # et est transformé par le form en  :selected_hotspots_id

    # # on définit nos coordonnées de départ
    # @startcoordinates = [@request.longitude, @request.latitude]


    #call the isochrone API to filter the hotspots

  end

  private

  def request_params
    params.require(:request).permit(:id, :distance, :longitude, :latitude, :selected_hotspots_id, category: [])
  end

end
