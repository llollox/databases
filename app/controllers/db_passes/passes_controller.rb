class PassesController < DbPassesController

  # GET /passes
  # GET /passes.json
  def index
    @passes, @alphaParams = 
       Pass.all.alpha_paginate(params[:letter], {:js => true, :bootstrap3 => true}){|pass| pass.name}
    respond_to do |format|
      format.html { render "layouts/sidebar" }
      format.json { render json: @passes }
    end
  end

  def map
    @passes = Pass.where("latitude IS NOT NULL")

    @markers = Gmaps4rails.build_markers(@passes) do |pass, marker|
      marker.lat pass.latitude
      marker.lng pass.longitude
      marker.title pass.id.to_s
      marker.infowindow pass.name
    end

    respond_to do |format|
      format.html { render "layouts/sidebar" }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def pass_params
    params.require(:pass).permit(
      :name,
      :altitude,
      :latitude,
      :longitude,
      :locality)
  end

end
