class Maps::CreateLocationHashes 
  
  attr_reader :objects, :boundaries
  
  def initialize(objects, boundaries: :point)
    @objects = objects
    @boundaries = boundaries
  end
  
  def perform
    locations = []
    
    objects.each do |object|
      type = object.model_name.element
      
      geocoded = point? ? nil : geocode(object)
      
      locations << {
        latitude: geocoded&["lat"] || object.latitude,
        longitude: geocoded&["lon"] || object.longitude,
        popup: create_html_popup(object),
        type: type
      }
    end
    
    locations
  end
  
  private 
  
  def create_html_popup(object)
    link = "/#{object.model_name.route_key}/#{object.id}"
    name = point? ? object.name.titleize : object.send(boundaries) 
    type = object.model_name.human
    
    "<a href='#{link}'>#{name}</a><br>#{type}"
  end
  
  def geocode(object)
    Geocoder.search(object.send(boundaries)).first.data # should either be city, region or country.
  end
  
  def point?
    boundaries == :point
  end
  
end