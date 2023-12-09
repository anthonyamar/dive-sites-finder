class DiveSitesController < ApplicationController
  
  def index
    @pagy, @dive_sites = pagy(DiveSite.order(Arel.sql('country IS NULL, country')).all)
  end

  def show
    @dive_site = DiveSite.find(params[:id])
    @closest_dive_centers = DiveCenter.near(@dive_site.to_coordinates, 100, units: :km).first(5)
    @dive_sites_around = DiveSite.near(@dive_site.to_coordinates, 10, units: :km).first(6).reject { |s| s.id == @dive_site.id }
    @locations = create_locations_array
  end
  
  private
  
  def create_locations_array
    dive_site_location = Maps::CreateLocationHashes.new([@dive_site]).perform
    dive_centers_locations = Maps::CreateLocationHashes.new(@closest_dive_centers).perform
    dive_sites_around_locations = Maps::CreateLocationHashes.new(@dive_sites_around).perform
    
    dive_site_location + dive_centers_locations + dive_sites_around_locations
  end
  
end
