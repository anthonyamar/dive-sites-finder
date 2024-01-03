class DestinationsController < ApplicationController
  
  def index
    @pagy, @destinations = pagy(Destination.order(Arel.sql('country')).all)
  end

  def country
    @destination = Destination.find_by(country: params[:country])
    @regions = Destination.regions_in_country(params[:country])
    
    load_associated_data
    
    destination_map = Maps::CreateLocationHashes.new([@destination], boundaries: :country).perform
    sites_and_centers = Maps::CreateLocationHashes.new(@dive_centers + @dive_sites).perform
    @locations = destination_map + sites_and_centers
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
    @dive_centers = DiveCenter.where(destination: @destination)
    @dive_sites = DiveSite.where(destination: @destination)
  end
   
end
