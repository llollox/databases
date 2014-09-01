class ProvincesController < DbMunicipalitiesController

  # GET /provinces
  # GET /provinces.json
  def index
    @provinces = Province.where(:region_id => params[:region_id]).
      sort_by{ |p| p.name.downcase }
  end

  # GET /provinces/1
  # GET /provinces/1.json
  def show
    @municipalities, @alphaParams = 
       @province.municipalities.sort_by{ |m| m.name.downcase }
         .alpha_paginate(params[:letter], {:js => true, :bootstrap3 => true}){|municipality| municipality.name}
  end

  # GET /provinces/new
  # GET /provinces/new.json
  def new
    @province = [Region.find(params[:region_id].to_i), Province.new]
    respond_to do |format|
      format.html { render "layouts/new_edit" }
    end
  end

  private
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def province_params
    params.require(:province).permit(
      :region_id,
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
