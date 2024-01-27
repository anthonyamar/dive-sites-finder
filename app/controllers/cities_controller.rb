class CitiesController < ApplicationController
  
  def show
    @city = City.friendly.find(params[:city])
    @dive_centers = @city.dive_centers
    @dive_sites = @city.dive_sites
    
    dive_locations = Maps::CreateLocationHashes.new(@dive_sites + @dive_centers).perform
    city_location = Maps::CreateLocationHashes.new([@city], boundaries: :city).perform
    @locations = city_location + dive_locations
  end
  
end
