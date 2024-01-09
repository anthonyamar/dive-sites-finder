require 'csv'

class Data::FillRegions
  
  ERROR_GEOCODED = []
  UPDATED = []
  
  def initialize
    Destination.where.not(city: nil, country: nil).where(region: nil).each do |destination|
      perform(destination)
    end
    create_csv_from_arrays
  end
  
  def perform(destination)
    return if !destination.region.blank?
    if !destination.latitude.blank? && !destination.longitude.blank?
      geocoded = Geocoder.search([destination.latitude, destination.longitude]).first
    else
      coordinates = Geocoder.search(destination.city).first.coordinates
      geocoded = Geocoder.search(coordinates).first
    end
    
    if geocoded.blank? || geocoded.data["error"]
      ERROR_GEOCODED << destination
      return
    end
    
    updated = destination.update_attribute!(:region, get_region(geocoded))
    UPDATED << destination if updated
  end
  
  def get_region(geocoded)
    address = geocoded.data["address"]
    if !address["state"].blank?
      address["state"]
    elsif !address["archipelago"].blank?
      address["archipelago"]
    elsif !address["island"].blank?
      address["island"]
    elsif !address["region"].blank?
      address["region"]
    elsif !address["state_district"].blank?
      address["state_district"]
    elsif !address["district"].blank?
      address["district"]
    elsif !address["county"].blank?
      address["county"]
    elsif !address["municipality"].blank?
      address["municipality"]
    elsif !address["postcode"].blank?
      address["postcode"]
    else
      "Unknown region"
    end
  end
  
  def create_csv_from_arrays
    arrays = {
      error_geocoded: ERROR_GEOCODED,
      updated: UPDATED,
    }
    
    arrays.each do |key, value|
      filename = Rails.public_path.join("fill_regions", "#{key}.csv").to_s
      write_to_csv(filename, value)
    end
  end
  
  def write_to_csv(filename, data)
    CSV.open(filename, "wb") do |csv|
      # En-têtes du fichier CSV
      csv << %w(ID name longitude latitude address region country)

      # Écriture des données
      data.each do |destination|
        row = [
          destination.id,
          destination.longitude,
          destination.latitude,
          destination.city,
          destination.region,
          destination.country,
        ]
        
        csv << row
      end
    end
  end
  
end