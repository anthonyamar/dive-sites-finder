class RegionsController < ApplicationController
  
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :must_be_admin, only: [:edit, :update]

  def show
    @region = Region.friendly.find(params[:region]).decorate
    @cities = @region.cities.order(dive_centers_count: :desc, dive_sites_count: :desc)
    @locations = Maps::CreateLocationHashes.new([@region, @cities].flatten, boundaries: :region).perform
  end 
  
  def edit
    @region = Region.friendly.find(params[:id])
  end

  def update
    @region = Region.friendly.find(params[:id])
    
    respond_to do |format|
      if @region.update(region_params)
        format.html { redirect_to region_path(country: @region.country, region: @region), notice: "#{@region.name} has been successfuly updated." }
        format.json { render :show, status: :ok, location: @region }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @region.errors, status: :unprocessable_entity }
      end
    end
  end

  private 
  
  def must_be_admin
    current_user.admin?
  end

  def region_params
    params.require(:region).permit(:name, :description, :latitude, :longitude, :slug)
  end

end
