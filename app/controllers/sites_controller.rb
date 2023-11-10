class SitesController < ApplicationController
  
  def index
    @pagy, @sites = pagy(Site.order(Arel.sql('country IS NULL, country')).all)
  end

  def show
    @site = Site.find(params[:id])
    @closest_dive_centers = DiveCenter.near(@site.to_coordinates, 100, units: :km).first(5)
  end
  
end
