class RegionsController < ApplicationController
  
  def show
    @region = Region.friendly.find(params[:region]).decorate
    @cities = @region.cities.order(dive_centers_count: :desc, dive_sites_count: :desc)
    @locations = Maps::CreateLocationHashes.new([@region, @cities].flatten, boundaries: :region).perform
  end
  
end
