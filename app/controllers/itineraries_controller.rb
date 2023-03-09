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

    @hotspots_ids = params[:itinerary][:hotspots_id]

    @itinerary.request = Request.find(params[:itinerary][:request_id])

    @itinerary.save

    # code stops here: a first instance of itinerary is being saved
    # now send it to mapbox
  end


  def show
  end

  private

  def itinerary_params
    params.require(:itinerary).permit(:duration, :length, :elevation,)
  end


end





# create_table "itineraries", force: :cascade do |t|
#   t.integer "duration"
#   t.float "length"
#   t.float "elevation"
#   t.boolean "favorite"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.bigint "request_id", null: false
#   t.index ["request_id"], name: "index_itineraries_on_request_id"
# end
