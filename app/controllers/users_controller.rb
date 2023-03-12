class UsersController < ApplicationController
  def favorites
    @user = current_user
    @favorites_itineraries = current_user.itineraries
  end

  def show
    @user = User.find(params[:id])
  end
end
