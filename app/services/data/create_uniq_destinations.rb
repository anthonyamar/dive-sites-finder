require 'csv'

class Data::CreateUniqDestinations
  
  attr_reader :countries, :regions
  
  COUNTRIES = []
  REGIONS = []

  def initialize
    @countries = Destination
      .select(:country)
      .distinct
      .pluck(:country)
    @regions = Destination
      .where.not(region: nil)
      .select(:country, :region)
      .distinct
  end

  def perform
    create_countries
    create_regions
    create_csv_from_arrays
  end
  
  private
  
  def create_countries
    # Identifier et créer des entrées pour chaque pays unique
    countries.each do |country|
      unless Destination.exists?(country: country, region: nil, city: nil)
        coordinates = get_coordinates(country)
        latitude = coordinates.nil? ? nil : coordinates[:latitude]
        longitude = coordinates.nil? ? nil : coordinates[:longitude]
        
        record = Destination.create(
          country: country,
          region: nil, 
          city: nil,
          country_code: country_to_code(country),
          latitude: latitude,
          longitude: longitude
        )
        
        COUNTRIES << record
        
        puts "Created country entry for #{country}"
      end
    end
  end
  
  def create_regions
    # Identifier et créer des entrées pour chaque région unique dans chaque pays
    regions.each do |destination|
      unless Destination.exists?(country: destination.country, region: destination.region, city: nil)
        coordinates = get_coordinates("#{destination.country}, #{destination.region}")
        latitude = coordinates.nil? ? nil : coordinates[:latitude]
        longitude = coordinates.nil? ? nil : coordinates[:longitude]
        
        record = Destination.create(
          country: destination.country,
          region: destination.region, 
          city: nil,
          country_code: country_to_code(destination.country),
          latitude: latitude,
          longitude: longitude
        )
        
        REGIONS << record
        
        puts "Created region entry for #{destination.region}, #{destination.country}"
      end
    end
  end
  
  def create_csv_from_arrays
    arrays = {
      countries: COUNTRIES,
      regions: REGIONS
    }
    
    arrays.each do |key, value|
      filename = Rails.public_path.join("create_uniq_destinations", "#{key}.csv").to_s
      write_to_csv(filename, value)
    end
  end
  
  def write_to_csv(filename, data)
    CSV.open(filename, "wb") do |csv|
      # En-têtes du fichier CSV
      csv << %w(ID city region country country_code latitude longitude)

      # Écriture des données
      data.each do |dest|
        row = [
          dest.id,
          dest.city,
          dest.region,
          dest.country,
          dest.country_code,
          dest.latitude,
          dest.longitude
        ]
        
        csv << row
      end
    end
  end
  
  def country_to_code(country)
    iso_country = ISO3166::Country.find_country_by_any_name(country)
    return iso_country.alpha2 if iso_country.present?
  end
  
  def get_coordinates(string_location)
    result = Geocoder.search(string_location).first
    if result
      return {
        latitude: result.latitude, 
        longitude: result.longitude
      }
    else
      puts "Coordonnées de '#{string_location}'non trouvées"
    end
  end

end