require 'csv'

class Data::DestinationsToGcrc
  
  CSV_FILE_PATH = Rails.public_path.join("destinations_to_gcrc").to_s
  
  def perform_countries
    CSV.open(CSV_FILE_PATH + "/countries.csv", "a") do |csv|
      csv << %w(name code latitude longitude saved id)
      
      Destination.where.not(country: nil).where(region: nil, city: nil).each do |destination|
        existing_country = Country.find_by(name: destination.country)
        next if !existing_country.nil?

        params = {
          name: destination.country,
          latitude: destination.latitude,
          longitude: destination.longitude,
          bounding_box: get_bounding_box(destination),
          code: destination.country_code.upcase,
          languages: split_language_string(destination.languages)
        }

        country = Country.new(params)
        country.dive_sites << destination.dive_sites
        country.dive_centers << destination.dive_centers

        csv_params = [country.name, country.code, country.latitude, country.longitude]
        if country.save
          csv << csv_params.push(true, country.id)
        else
          csv << csv_params.push(false)
        end
      end
    end
  end
  
  def perform_regions
    CSV.open(CSV_FILE_PATH + "/regions.csv", "a") do |csv|
      csv << %w(name country latitude longitude saved id)
      
      Destination.where.not(country: nil, region: nil).where(city: nil).each do |destination|
        country = Country.find_by(name: destination.country)
        existing_region = Region.find_by(name: destination.region, country: country)
        next if !existing_region.nil?

        params = {
          name: destination.region,
          latitude: destination.latitude,
          longitude: destination.longitude,
          bounding_box: get_bounding_box(destination),
          country: country
        }

        region = Region.new(params)
        region.dive_sites << destination.dive_sites
        region.dive_centers << destination.dive_centers
        
        csv_params = [region.name, region.country&.name, region.latitude, region.longitude]
        if region.save
          csv << csv_params.push(true, region.id)
        else
          csv << csv_params.push(false)
        end
      end
    end
  end
  
  def perform_cities
    CSV.open(CSV_FILE_PATH + "/cities.csv", "a") do |csv|
      csv << %w(name country region latitude longitude timezone saved id)
      
      Destination.where.not(country: nil, region: nil, city: nil).each do |destination|
        country = Country.find_by(name: destination.country)
        region = Region.find_by(name: destination.region, country: country)
        existing_city = City.find_by(name: destination.city, region: region)
        next if !existing_city.nil?

        params = {
          name: destination.city,
          latitude: destination.latitude,
          longitude: destination.longitude,
          bounding_box: get_bounding_box(destination),
          timezone: get_timezone(destination),
          region: region
        }
        
        city = City.new(params)
        city.dive_sites << destination.dive_sites
        city.dive_centers << destination.dive_centers
        
        csv_params = [city.name, city.region&.country&.name, city.region&.name, city.latitude, city.longitude, city.timezone]
        
        if city.save
          csv << csv_params.push(true, city.id)
        else
          csv << csv_params.push(false)
        end
      end
    end
  end
  
  private
  
  def get_bounding_box(destination)
    location = Geocoder.search(destination.full_address).first
    
    if location.nil? || location.boundingbox.nil?
      puts "No location or bounding box found for #{destination.full_address} ##{destination.id}"
      return nil
    else
      location.boundingbox
    end
  end
  
  def get_timezone(destination)
    if !destination.timezone.blank?
      return destination.timezone
    else
      nearest_city_with_timezone = City
        .where.not(timezone: nil)
        .near(destination.to_coordinates, 50, units: :km)
        .first
      
      if nearest_city_with_timezone.nil?
        begin
          Timezone.lookup(destination.latitude, destination.longitude).name
        rescue => e
          puts "ERROR timezone: #{destination.full_address}, ##{destination.id}"
          puts e.message
          return
        end
      else
        nearest_city_with_timezone.timezone
      end
    end
  end
  
  def split_language_string(input)
    return nil if input.blank?
    input.gsub(/ and /, ', ').split(', ').map(&:strip)
  end
  
end