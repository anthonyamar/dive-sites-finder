class CitiesController < ApplicationController
  
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :must_be_admin, only: [:edit, :update]
  
  def show
    @city = City.friendly.find(params[:city]).decorate
    @dive_centers = @city.dive_centers
    @dive_sites = @city.dive_sites
    
    dive_locations = Maps::CreateLocationHashes.new(@dive_sites + @dive_centers).perform
    city_location = Maps::CreateLocationHashes.new([@city], boundaries: :city).perform
    @locations = city_location + dive_locations
  end
  
  def edit
    @city = City.friendly.find(params[:id])
  end

  def update
    @city = City.friendly.find(params[:id])
    
    respond_to do |format|
      if @city.update(city_params)
        format.html { redirect_to city_path(country: @city.country, region: @city.region, city: @city), notice: "#{@city.name} has been successfuly updated." }
        format.json { render :show, status: :ok, location: @city }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  private 
  
  def must_be_admin
    current_user.admin?
  end

  def city_params
    params.require(:city).permit(:name, :description, :latitude, :longitude, :slug, :timezone, :capital_city)
  end

  
end
