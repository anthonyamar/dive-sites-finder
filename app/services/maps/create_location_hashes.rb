class Maps::CreateLocationHashes 
  
  attr_reader :objects, :boundaries
  
  def initialize(objects, boundaries: :point)
    @objects = objects
    @boundaries = boundaries
  end
  
  def perform
    locations = []
    
    objects.each do |object|
      coordinates = geocode(object)
      next if coordinates.nil?
      
      locations << {
        latitude: coordinates[:lat],
        longitude: coordinates[:lon],
        popup: create_html_popup(object),
        type: object.model_name.element
      }
    end
    
    locations
  end
  
  private 
  
  def create_html_popup(object)
    link = create_link_from_object(object)
    name = object.name.titleize
    type = object.model_name.human
    
    "<a href='#{link}'>#{name}</a><br>#{type}"
  end
  
  def geocode(object)
    unless has_coordinates?(object)
      object = create_coordinates(object)
    end
    return nil unless has_coordinates?(object)
    { lat: object.latitude, lon: object.longitude }
  end
  
  def point?
    boundaries == :point
  end
  
  def has_coordinates?(object)
    object.latitude.present? && object.longitude.present?
  end
  
  def create_coordinates(object)
    geocoded = Geocoder.search(object.send(boundaries)).first&.data # should either be city, region or country.
    object.update(latitude: geocoded["lat"], longitude: geocoded["lon"]) unless geocoded.nil?
    object
  end
  
  def create_link_from_object(object)
    case boundaries
      when :point
        "/#{object.model_name.route_key}/#{object.slug}"
      when :country
        "/countries/#{object.slug}"
      when :region
        "/#{object.country.slug}/#{object.slug}"
      when :city
        "/#{object.country.slug}/#{object.region.slug}/#{object.slug}"
    end
  end
  
end