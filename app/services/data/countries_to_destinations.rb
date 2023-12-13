class Data::CountriesToDestinations
  
  def perform
    DiveCenter.where(destination_id: nil).each do |dive_center|
      consolidate_location(dive_center)
    end
    
    DiveSite.where(destination_id: nil).each do |dive_site|
      consolidate_location(dive_site)
    end
  end
  
  def consolidate_location(item)
    location = Geocoder.search([item.latitude, item.longitude]).first
    
    nil_locations = []
    if !location.nil? && item.destination.blank?
      destination = Destination.find_by(
        city: location.city,
        region: location.state,
        country: location.country
      )
      
      if destination.nil? 
        destination = Destination.create(
          city: location.city,
          region: location.state,
          country: location.country,
          country_code: location.country_code,
          timezone: Timezone.lookup(item.latitude, item.longitude).name || nil,
          languages: ISO3166::Country.new(location.country_code).languages_official.to_sentence
        )
      end

      # Trouver un moyen de faire l'appel de la timezone que si celle-ci n'existe pas 
      # Autrement, il va falloir trouver un moyen de passer outre les limites de GeoNames.org
      
      item.update(destination: destination)
    end
  end
  
end