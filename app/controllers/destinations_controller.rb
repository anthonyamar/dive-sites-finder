class DestinationsController < ApplicationController
  
  def index
    @pagy, @destinations = pagy(Destination.order(Arel.sql('country')).all)
  end

  def country

    @destination = Destination.find_by(country: params[:country], region: nil, city: nil)
    @regions = Destination.regions_in_country(params[:country])
    
    @locations = Maps::CreateLocationHashes.new([@destination], boundaries: :country).perform
    
    load_associated_data
  end

  def region
    @destination = Destination.find_by(region: params[:region])
    puts @destination.id
    @destinations = Destination
      .where(region: @destination.region)
#      .where.not(id: @destination.id)
    @locations = Maps::CreateLocationHashes.new([@destination], boundaries: :region).perform
    
    load_associated_data
  end

  def city
    @destination = Destination.find_by(city: params[:city])
    @locations = Maps::CreateLocationHashes.new([@destination], boundaries: :city).perform
    
    load_associated_data
  end

  private

  def load_associated_data
    @dive_centers = DiveCenter.where(destination: @destinations)
    @dive_sites = DiveSite.where(destination: @destinations)
  end
   
end
