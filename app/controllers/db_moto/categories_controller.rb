class CategoriesController < DbMotoController

  # GET /categories
  # GET /categories.json
  def index
    @categories, @alphaParams = 
      Category.all.sort_by{ |c| c.name.downcase }
        .alpha_paginate(params[:letter], {:js => true, :bootstrap3 => true}){|category| category.name}
    
    respond_to do |format|
      format.html { render "layouts/sidebar" }
      format.json { render json: @categories }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params
    params.require(:category).permit(:name)
  end
end
