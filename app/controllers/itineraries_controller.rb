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

    @itinerary.request = Request.find(params[:itinerary][:request_id])


    @hotspot_ids = params[:itinerary][:selected_hotspots_id]

    @hotspot_ids = @hotspot_ids.split(" ");



    @itinerary.selected_hotspot_ids = @hotspot_ids




    @itinerary.save

    if @itinerary.save
      redirect_to itinerary_path(@itinerary)
    end
    # code stops here: a first instance of itinerary is being saved
    # now send it to mapbox
  end


  def show
    @itinerary = Itinerary.find(params[:id])
    @hotspot_instances = []

    @itinerary.selected_hotspot_ids.each do |hotspot|
      @hotspot_instances << Hotspot.find(hotspot.to_i)
    end

    @markers = @hotspot_instances.map do |hotspot|
      {
        lat: hotspot.latitude,
        lng: hotspot.longitude
      }
    end

    # j'instancie mon array de coordonnées
    @passingcoordinates = []
    # j'y ajoute ma coordonnée de départ
    @passingcoordinates << [@itinerary.request.longitude, @itinerary.request.latitude]
    #  je compile
    @hotspot_instances.each do |hotspot|
      @passingcoordinates << [hotspot.longitude, hotspot.latitude]
    end
    # j'y ajoute ma coordonnée de fin
    @passingcoordinates << [@itinerary.request.longitude, @itinerary.request.latitude]
    # j'interpole le tout au bon format pour la requete API
    @passingcoordinates = @passingcoordinates.map {|coord| coord.join(", ") }.join("; ")


  end


  def update
    raise
  end

  private

  def itinerary_params
    params.require(:itinerary).permit(:duration, :length, :elevation,)
  end


end
