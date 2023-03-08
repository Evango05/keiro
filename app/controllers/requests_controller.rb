class RequestsController < ApplicationController
  def new
    @request = Request.new
    @hotspots = Hotspot.all
    @markers = @hotspots.geocoded.map do |hotspot|
      {
        lat: hotspot.latitude,
        lng: hotspot.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { hotspot: hotspot }),
        marker_html: render_to_string(partial: "marker", locals: { hotspot: hotspot })
      }
    end
  end

  def create
    @request = Request.new(request_params)
    @request.user = current_user
    @request.category = params[:request][:category]
    @request.category = @request.category.drop(1)

    @request.save
    # no need to create a view for create
    redirect_to request_path(@request)
  end

  def show
    @request = Request.find(params[:id])
    raise
  end

  private

  def request_params
    params.require(:request).permit(:distance, :category)
  end
end
