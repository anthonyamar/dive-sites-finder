class CountriesController < ApplicationController
  
  def index
    @countries = Country.all  
  end
  
  def show
    @country = Country.friendly.find(params[:id]).decorate
    @regions = @country.regions.order(cities_count: :desc)
    @locations = Maps::CreateLocationHashes.new([@country, @regions].flatten, boundaries: :country).perform
  end
  
end
