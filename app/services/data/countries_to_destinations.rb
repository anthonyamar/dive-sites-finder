class Data::CountriesToDestinations
  
  NIL_LOCATION = []
  ERROR_ITEM = []
  
  attr_reader :updated
  
  def perform
    @updated = 0
    
    DiveCenter.where(destination_id: nil).each do |dive_center|
      consolidate_location(dive_center)
    end
    
    DiveSite.where(destination_id: nil).each do |dive_site|
      consolidate_location(dive_site)
    end
    
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
      if item.destination.blank?
        destination = Destination.find_by(
          city: location.city,
          region: location.state,
          country: location.country
        )

        if destination.nil? 
          puts "No destination founded, creating one..."
          params = {
            city: location.city,
            region: location.state,
            country: location.country,
            country_code: location.country_code,
            #timezone: Timezone.lookup(item.latitude, item.longitude).name || nil,
            languages: ISO3166::Country.new(location.country_code).languages_official.to_sentence
          }

          destination = Destination.new(params)
          destination.save!
        else
          puts "Destination ##{destination.id} founded. Attaching to item..."
        end
        
        item_updated = item.update_attribute(:destination, destination)
        if item_updated
          puts "Destination ##{destination.id} attached to #{item.model_name.element} ##{item.id}"
          @updated += 1
        else
          puts "Item not updated"
          puts item_updated
        end
      else
        puts "Item ##{item.id} (#{item.model_name.element}) already have destination ##{destination.id} attached - #{destination.country}, #{destination.region}, #{destination.city}"
        return
      end # end if item.destination.blank?
    rescue => e
      ERROR_ITEM << item
      puts "#{item.model_name.element} ##{item.id} had an error"
      puts e.message
      return
    end # end begin/rescue
      
  end # end consolidate_location
  
  def prompt_finish
    puts "=============== FINISH =================="
    puts "#{updated} updated items."
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