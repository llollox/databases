class BrandsController < DbMotoController

  # GET /brands
  # GET /brands.json
  def index
    @brands, @alphaParams = 
      Brand.all.sort_by{ |b| b.name.downcase }
        .alpha_paginate(params[:letter], {:js => true, :bootstrap3 => true}){|brand| brand.name}
    
    respond_to do |format|
      format.html { render "layouts/sidebar" }
      format.json { render json: @brands }
    end
  end

  # # GET /brands/1
  # # GET /brands/1.json
  def show
    @models, @alphaParams = 
      @brand.models.sort_by{ |m| m.name.downcase }
        .alpha_paginate(params[:letter], {:js => true, :bootstrap3 => true}){|model| model.name}
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def brand_params
    params.require(:brand).permit(
      :logo,
      :logo_url, 
      :name)
  end
end
