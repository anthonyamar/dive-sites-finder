class Data::DestinationsToGcrc
  
  def initialize
    
    
  end
  
  def perform_countries
    Destination.where.not(country: nil).where(region: nil, city: nil).each do |destination|
      params = {
        name: destination.country,
        latitude: destination.latitude,
        longitude: destination.longitude,
        bounding_box: get_bounding_box(destination),
        code: destination.country_code.upcase,
        
      }
    end
  end
  
  def perform_regions
    
  end
  
  def perform_cities
    
  end
  
  private
  
  def get_bounding_box(destination)
    location = Geocoder.search(destination.name).first
    
    if location.nil? || location.boundingbox.nil?
      NIL_LOCATION << item
      puts "No location or bounding box found for #{destination.name} ##{destination.id}"
      return nil
    else
      location.boundingbox
    end
  end
  
end