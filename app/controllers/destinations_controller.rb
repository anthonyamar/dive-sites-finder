class DestinationsController < ApplicationController
  
  def index
    @pagy, @destinations = pagy(Destination.order(Arel.sql('country')).all)
  end

  def country
    @destination = Destination.find_by(country: params[:country])
    @destinations = Destination
      .where(country: @destination.country)
      .where.not(id: @destination.id)
    
    load_associated_data
  end

  def region
    @destination = Destination.find_by(region: params[:region])
    @destinations = Destination
      .where(region: @destination.region)
      .where.not(id: @destination.id)
    
    load_associated_data
  end

  def city
    @destination = Destination.find_by(city: params[:city])
    
    load_associated_data
  end

  private

  def load_associated_data
    @dive_centers = DiveCenter.where(destination: @destinations)
    @dive_sites = DiveSite.where(destination: @destinations)
  end
   
end
