class SitesController < ApplicationController
  
  def index
    @pagy, @sites = pagy(Site.order(Arel.sql('country IS NULL, country')).all)
  end

  def show
    @site = Site.find(params[:id])
    @closest_dive_centers = DiveCenter.near(@site.to_coordinates, 100, units: :km).first(5)
    @sites_around = Site.near(@site.to_coordinates, 10, units: :km).first(6).reject { |s| s.id == @site.id }
    @locations = create_locations_array
  end
  
  private
  
  def create_locations_array
    site_location = Maps::CreateLocationHashes.new([@site]).perform
    dive_centers_locations = Maps::CreateLocationHashes.new(@closest_dive_centers).perform
    sites_around_locations = Maps::CreateLocationHashes.new(@sites_around).perform
    
    site_location + dive_centers_locations + sites_around_locations
  end
  
end
