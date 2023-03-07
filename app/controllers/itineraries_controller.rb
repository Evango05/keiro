class ItinerariesController < ApplicationController

  def index
    @itineraries = Itinerary.all
  end

  def new
    @itinerary = Itinerary.new
  end

  def create
    @itinerary = Itinerary.new(itinerary_params)
    @itinerary.save
    # no need to create a view for create
    # redirect_to itinerary_path(@itinerary)
  end

  def show
  end
end
