require 'csv'

class Data::UnassociateWrongDestinations
  
  attr_reader :dive_sites
  
  SITES_WO_COUNTRY = []
  SITES_WO_REGION = []
  SITES_WO_CITY = []
  SITES_OK = []
  SITES_WO_DEST = []
  SITES_WO_LOCATION = []
  
  def initialize
    @dive_sites = DiveSite.all.each do |dive_site|
      perform(dive_site)
    end
    
    create_csv_from_arrays
  end
  
  def perform(dive_site)
    if dive_site.destination
      location = Geocoder.search([dive_site.latitude, dive_site.longitude]).first
      
      if location.blank?
        SITES_WO_LOCATION << dive_site
        return
      end
      
      country = location.country
      region = location.state
      city = location.city
      
      if country.blank?
        dive_site.update_attribute(:destination_id, nil)
        puts "DiveSite ##{dive_site.id} dissociated from incorrect Destination"
        SITES_WO_COUNTRY << dive_site
      elsif region.blank? 
        dive_site.update_attribute(:destination_id, nil)
        puts "DiveSite ##{dive_site.id} dissociated from incorrect Destination - NO REGION, BUT COUNTRY"
        SITES_WO_REGION << dive_site
      elsif city.blank?
        dive_site.update_attribute(:destination_id, nil)
        puts "DiveSite ##{dive_site.id} dissociated from incorrect Destination - NO CITY, BUT REGION AND COUNTRY"
        SITES_WO_CITY << dive_site
      else
        puts "DiveSite ##{dive_site.id} and Destination ##{dive_site.destination.id} are matching"
        SITES_OK << dive_site
      end
      
    else
      puts "DiveSite ##{dive_site.id} don't have destination"
      SITES_WO_DEST << dive_site
    end
  end
  
  def create_csv_from_arrays
    arrays = {
      wo_country: SITES_WO_COUNTRY,
      wo_region: SITES_WO_REGION,
      wo_city: SITES_WO_CITY,
      ok: SITES_OK,
      wo_dest: SITES_WO_DEST,
      wo_location: SITES_WO_LOCATION,
    }
    
    arrays.each do |key, value|
      filename = Rails.public_path.join("unassociated_sites", "#{key}.csv").to_s
      write_to_csv(filename, value)
    end
  end
  
  def write_to_csv(filename, data)
    CSV.open(filename, "wb") do |csv|
      # En-têtes du fichier CSV
      csv << %w(ID name longitude latitude address region country destination_id)

      # Écriture des données
      data.each do |site|
        row = [
          site.id,
          site.name,
          site.longitude,
          site.latitude,
          site.address,
          site.region,
          site.country,
          site.destination_id
        ]
        
        csv << row
      end
    end
  end
  
end
