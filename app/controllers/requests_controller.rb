class RequestsController < ApplicationController
  def new
    @request = Request.new
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
