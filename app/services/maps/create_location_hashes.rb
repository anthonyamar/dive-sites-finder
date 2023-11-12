class Maps::CreateLocationHashes 
  
  attr_reader :objects, :color
  
  COLORS = {
    red: "#f43f5e",
    blue: "#0ea5e9",
    green: "#22c55e"
  }
  
  def initialize(objects, color = :red)
    @objects = objects
    @color = COLORS[color]
  end
  
  def perform
    locations = []
    
    objects.each do |object|
      locations << {
        latitude: object.latitude,
        longitude: object.longitude,
        label: object.name,
        color: color
      }
    end
    
    locations
  end
  
end