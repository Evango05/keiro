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
    @request.category = @request.category.drop(1)

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

    @selected_hotspots_ids = []

    array.each do |category|
      @selected_hotspots_ids << category.hotspots.ids
    end

    @selected_hotspots_ids = @selected_hotspots_ids.flatten.uniq!

    #DEBUG == ici @selected_hotspots_ids fonctionne parfaitement
    # et est transformé par le form en  :selected_hotspots_id

    # # on définit nos coordonnées de départ
    # @startcoordinates = [@request.longitude, @request.latitude]

  end

  private

  def request_params
    params.require(:request).permit(:id, :distance, :category, :longitude, :latitude, :selected_hotspots_id)
  end

end
