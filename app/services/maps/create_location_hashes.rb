class Maps::CreateLocationHashes 
  
  attr_reader :objects
  
  def initialize(objects)
    @objects = objects
  end
  
  def perform
    locations = []
    
    objects.each do |object|
      locations << {
        latitude: object.latitude,
        longitude: object.longitude,
        popup: create_html_popup(object),
        type: object.model_name.element
      }
    end
    
    locations
  end
  
  private 
  
  def create_html_popup(object)
    link = show_link(object)
    name = object.name.titleize
    kind = object.model_name.element == "site" ? "Dive site" : "Dive center"
    
    "<a href='#{link}'>#{name}</a><br>#{kind}"
  end
  
  def show_link(object)
    if object.model_name.element == "site"
      "/sites/#{object.id}"
    else
      "/dive_centers/#{object.id}"
    end
  end
  
end