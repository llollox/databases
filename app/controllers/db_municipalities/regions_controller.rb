class RegionsController < DbMunicipalitiesController
  
  # GET /regions
  # GET /regions.json
  def index
    @regions, @alphaParams = 
      Region.all.sort_by{ |r| r.name.downcase }
        .alpha_paginate(params[:letter], {:js => true, :bootstrap3 => true}){|region| region.name}
    
    respond_to do |format|
      format.html { render "layouts/sidebar" }
      format.json { render json: @brands }
    end
  end

  # GET /regions/1
  # GET /regions/1.json
  def show
    @provinces, @alphaParams = 
      @region.provinces.sort_by{ |p| p.name.downcase }
        .alpha_paginate(params[:letter], {:js => true, :bootstrap3 => true}){|province| province.name}
  end

  private
  


  # Never trust parameters from the scary internet, only allow the white list through.
  def region_params
    params.require(:region).permit(
      :name,
      :capital_id,
      :president,
      :population,
      :density,
      :surface,
      :abbreviation,
      :email,
      :website)
  end
end
