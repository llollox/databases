class MunicipalitiesController < DbMunicipalitiesController
  
  # GET /municipalities
  # GET /municipalities.json
  def index
    @municipalities = Municipality.where(:province_id => params[:province_id]).
      sort_by{ |m| m.name.downcase }
  end

  def map
    @municipalities = Municipality.where("latitude IS NOT NULL")

    @markers = Gmaps4rails.build_markers(@municipalities) do |municipality, marker|
      marker.lat municipality.latitude
      marker.lng municipality.longitude
      marker.title municipality.id.to_s
      marker.infowindow "Loading ..."
    end

    respond_to do |format|
      format.html { render "layouts/sidebar" }
      format.json { render json: @municipalities }
    end
  end

  # GET /municipalities/1
  # GET /municipalities/1.json
  def show
    @fractions, @alphaParams = 
       @municipality.fractions.sort_by{ |m| m.name.downcase }
         .alpha_paginate(params[:letter], {:js => true, :bootstrap3 => true}){|fraction| fraction.name}
  end

  def infobox
    @municipality = Municipality.find(params[:municipality_id])
    respond_to do |format|
      format.html { render :layout => false} # infobox.html.erb
      format.json { render json: @municipality }
    end
  end

  # GET /municipalities/new
  # GET /municipalities/new.json
  def new
    @municipality = [Province.find(params[:province_id].to_i), Municipality.new]
    respond_to do |format|
      format.html { render "layouts/new_edit" }
    end
  end

  private
  
  # # Use callbacks to share common setup or constraints between actions.
  # def set_municipality
  #   @municipality = Municipality.find(params[:id])
  # end

  # Never trust parameters from the scary internet, only allow the white list through.
  def municipality_params
    params.require(:municipality).permit(
      :province_id,
      :region_id,
      :name,
      :president,
      :population,
      :density,
      :surface,
      :istat_code,
      :cadastral_code,
      :telephone_prefix,
      :abbreviation,
      :email,
      :website,
      :latitude,
      :longitude)
  end
end
