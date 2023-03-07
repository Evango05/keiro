class RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    @request.save
    # no need to create a view for create
    redirect_to itinerary_path(@itinerary)
  end

  private

  def request_params
    params.require(:request).permit(:constant_categories)
  end
end
