class DiveCentersController < ApplicationController
  
  def index
    @pagy, @dive_centers = pagy(DiveCenter.order(Arel.sql('country_code IS NULL, country_code')).all)
  end

  def show
    @dive_center = DiveCenter.find(params[:id])
  end
  
end
