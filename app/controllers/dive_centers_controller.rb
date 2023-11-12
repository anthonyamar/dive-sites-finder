class DiveCentersController < ApplicationController
  
  def index
    @pagy, @dive_centers = pagy(DiveCenter.order(Arel.sql('country_code IS NULL, country_code')).all)
  end

  def show
    @dive_center = DiveCenter.find(params[:id])
    @closest_sites = Site.near(@dive_center.to_coordinates, 50, units: :km).first(5)
    @locations = create_locations_array
  end
  
  private
  
  def create_locations_array
    dive_center_location = Maps::CreateLocationHashes.new([@dive_center], :red).perform
    sites_around_locations = Maps::CreateLocationHashes.new(@closest_sites, :blue).perform
    
    dive_center_location + sites_around_locations
  end
  
end
