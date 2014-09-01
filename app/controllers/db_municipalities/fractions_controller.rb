class FractionsController < DbMunicipalitiesController

  def index
    @fractions = Fraction.where(:municipality_id => params[:municipality_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fractions }
    end
  end

  # GET /municipalities/new
  # GET /municipalities/new.json
  def new
    @fraction = [Municipality.find(params[:municipality_id].to_i), Fraction.new]
    respond_to do |format|
      format.html { render "layouts/new_edit" }
    end
  end

  private

  def fraction_params
    params.require(:fraction).permit(
      :municipality,
      :municipality_id,
      :name,
      :latitude,
      :longitude)
  end
end
