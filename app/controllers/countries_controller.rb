class CountriesController < ApplicationController
  
  def index
    @countries = Country.all  
  end
  
  def show
    @country = Country.friendly.find(params[:id])
    # Add @locations to get the map done
  end
  
end
