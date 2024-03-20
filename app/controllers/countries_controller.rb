class CountriesController < ApplicationController
  
  before_action :set_country, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :must_be_admin, only: [:edit, :update]
  
  def index
    @countries = Country.all  
  end
  
  def show
    @regions = @country.regions.order(cities_count: :desc)
    @locations = Maps::CreateLocationHashes.new([@country, @regions].flatten, boundaries: :country).perform
  end
  
  def edit
  end

  def update
    respond_to do |format|
      if @country.update(country_params)
        format.html { redirect_to @country, notice: "#{@country.name} has been successfuly updated." }
        format.json { render :show, status: :ok, location: @country }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  private 

  def set_country
    @country = Country.friendly.find(params[:id]).decorate
  end

  def must_be_admin
    current_user.admin?
  end

  def country_params
    params.require(:country).permit(:name, :description, :latitude, :longitude, :code, :demonym, :currency, :pressure, :phone_prefix, :voltage, :plug, :meta_description, :slug)
  end
  
end
