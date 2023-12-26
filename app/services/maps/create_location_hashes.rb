class Maps::CreateLocationHashes 
  
  attr_reader :objects, :boundaries
  
  def initialize(objects, boundaries: :point)
    @objects = objects
    @boundaries = boundaries
  end
  
  def perform
    locations = []
    
    objects.each do |object|
      locations << {
        latitude: geocode(object)[:lat],
        longitude: geocode(object)[:lon],
        popup: create_html_popup(object),
        type: object.model_name.element
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
    if point?
      { lat: object.latitude, lon: object.longitude, bounds: nil }
    else
#      binding.pry
      geocoded = Geocoder.search(object.send(boundaries)).first.data # should either be city, region or country.
      { lat: geocoded["lat"], lon: geocoded["lon"], bounds: geocoded["boundingbox"] }
    end
  end
  
  def point?
    boundaries == :point
  end
  
end