class HotspotsController < ApplicationController
  before_action :set_hotspot, only: %i[show edit update destroy]

  # GET /hotspots or /hotspots.json

  # GET /hotspots/1 or /hotspots/1.json
  def show
  end

  # GET /hotspots/new
  def new
    @hotspot = Hotspot.new
  end

  # GET /hotspots/1/edit
  def edit
  end

  # POST /hotspots or /hotspots.json
  def create
    @hotspot = Hotspot.new(hotspot_params)

    respond_to do |format|
      if @hotspot.save
        format.html { redirect_to hotspot_url(@hotspot), notice: "Hotspot was successfully created." }
        format.json { render :show, status: :created, location: @hotspot }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @hotspot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hotspots/1 or /hotspots/1.json
  def update
    respond_to do |format|
      if @hotspot.update(hotspot_params)
        format.html { redirect_to hotspot_url(@hotspot), notice: "Hotspot was successfully updated." }
        format.json { render :show, status: :ok, location: @hotspot }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @hotspot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hotspots/1 or /hotspots/1.json
  def destroy
    @hotspot.destroy

    respond_to do |format|
      format.html { redirect_to hotspots_url, notice: "Hotspot was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hotspot
      @hotspot = Hotspot.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hotspot_params
      params.require(:hotspot).permit(:name, :description, :hotspot_picture, :address, :latitude, :longitude)
    end
end
