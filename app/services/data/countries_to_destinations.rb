require 'csv'

class Data::CountriesToDestinations
  
  NIL_LOCATION = []
  ERROR_ITEM = []
  UPDATED = []
  MAX_SEARCH_DISTANCE = 100 # km
  
  attr_reader :updated
  
  def perform
    @updated = 0
    
    DiveSite.where(destination_id: nil).each do |dive_site|
      puts "START DIVE SITE --------------------------------------"
      consolidate_location(dive_site)
      puts "END DIVE SITE --------------------------------------"
    end
    
    DiveCenter.where(destination_id: nil).each do |dive_center|
      puts "START DIVE CENTER --------------------------------------"
      consolidate_location(dive_center)
      puts "END DIVE CENTER --------------------------------------"
    end
    
    puts "CREATING CSV"
    create_csv_from_arrays
    prompt_finish
  end
  
  def consolidate_location(item)
    
    location = Geocoder.search([item.latitude, item.longitude]).first
    
    if location.nil?
      NIL_LOCATION << item
      puts "No location found for #{item.model_name.element} ##{item.id}"
      return
    else
      puts "Location found -> #{location.country}, #{location.state}, #{location.city}"
    end
    
    begin
      destination = find_destination(location, item)

      if destination.nil? && location_error?(location)
        error_item(item, "Location error and no destinations found at all.")
        return
      elsif destination.nil? && !location_error?(location)
        destination = create_destination(location)
      else
        puts "Destination ##{destination.id} founded. Attaching to item..."
      end

      item_updated = item.update_attribute(:destination, destination)
      if item_updated
        puts "Destination ##{destination.id} attached to #{item.model_name.element} ##{item.id}"
        @updated += 1
        UPDATED << item
        return
      else
        puts "Item not updated"
        puts item_updated
      end
    rescue => e
      error_item(item, e.message)
      return
    end # end begin/rescue
      
  end # end consolidate_location
  
  def find_destination(location, item)
    nearest_destination = Destination
        .near([item.latitude, item.longitude], MAX_SEARCH_DISTANCE, units: :km)
        .first
    
    if location_error?(location)
      if nearest_destination.nil?
        NIL_LOCATION << item
        puts "No location found for #{item.model_name.element} ##{item.id}"
        return nil
      else
        puts "Location error: Find by nearest destination: ##{nearest_destination.id}."
        return nearest_destination
      end
    else
      founded_destination = Destination.find_by(
        city: location.city,
        region: get_region(location),
        country: location.country
      )
      return nil if nearest_destination.nil? && founded_destination.nil?
      return founded_destination if nearest_destination.nil?
      
      if nearest_destination != founded_destination || founded_destination.nil?
        puts "Nearest and founded destinations not the same. Use nearest one: ##{nearest_destination.id}"
        nearest_destination
      else
        founded_destination
      end
    end
  end
  
  def create_destination(location)
    puts "No destination founded, creating one..."
    params = {
      city: location.city,
      region: get_region(location),
      country: location.country,
      country_code: location.country_code,
      timezone: get_timezone(location),
      languages: ISO3166::Country.new(location.country_code).languages_official.to_sentence
    }

    destination = Destination.create!(params)
    destination
  end
  
  def location_error?(location)
    location.data["error"] == "Unable to geocode"
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
  
  def get_timezone(location)
    begin
      Timezone.lookup(location.latitude, location.longitude).name
    rescue => e
      puts e.message
      nearest_timezone = Destination
        .where.not(timezone: nil)
        .near([location.latitude, location.longitude], MAX_SEARCH_DISTANCE, units: :km)
        .first
      return nearest_timezone
    end
  end
  
  def create_csv_from_arrays
    arrays = {
      nil_location: NIL_LOCATION,
      error_item: ERROR_ITEM,
      updated: UPDATED
    }
    
    arrays.each do |key, value|
      filename = Rails.public_path.join("countries_to_destinations", "#{key}.csv").to_s
      write_to_csv(filename, value)
    end
  end
  
  def write_to_csv(filename, data)
    CSV.open(filename, "wb") do |csv|
      csv << %w(ID type name longitude latitude destination_id)

      data.each do |item|
        row = [
          item.id,
          item.model_name.element,
          item.name,
          item.longitude,
          item.latitude,
          item.destination_id
        ]
        
        csv << row
      end
    end
  end
  
  def error_item(item, message)
    ERROR_ITEM << item
    puts "#{item.model_name.element} ##{item.id} had an error"
    puts message
  end
  
  def prompt_finish
    puts "=============== FINISH =================="
    puts "#{@updated} updated items."
    puts "========================================="
    puts "NIL_LOCATION (#{NIL_LOCATION.size}):"
    NIL_LOCATION.each do |item|
      puts "#{item.model_name.element} ##{item.id}"
    end
    puts "========================================="
    puts "ERROR_ITEM (#{ERROR_ITEM.size}):"
    ERROR_ITEM.each do |item|
      puts "#{item.model_name.element} ##{item.id}"
    end
    puts "========================================="
  end
  
end