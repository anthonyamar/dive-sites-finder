class DiveCentersController < ApplicationController
  
  def index
    @pagy, @dive_centers = pagy(DiveCenter.order(Arel.sql('country_code IS NULL, country_code')).all)
  end

  def show
    @dive_center = DiveCenter.find(params[:id])
    @closest_sites = Site.near(@dive_center.to_coordinates, 50, units: :km).first(5)
  end
  
end
