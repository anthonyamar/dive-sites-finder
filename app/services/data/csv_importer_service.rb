require "csv"

class Data::CsvImporterService
  
  def initialize(file_path)
    @file_path = file_path
  end

  def import_sites_data
    CSV.foreach(@file_path, headers: true) do |row|
      record = DiveSite.new(
        name: row['odin_dive_sites_name'],
        bow: row['bow'].blank? ? "unknown" : row['bow'],
        longitude: row['longitude'],
        latitude: row['latitude'],
        address: row['address'],
        region: row['region'],
        country: row['country'],
        is_private: row['is_private'] == 1 ? true : false
      )

      if record.save
        puts "Record created: #{record.name}"
      else
        puts "Error creating record: #{record.errors.full_messages.join(', ')}"
      end
    end
  end
  
  def import_dive_center_data
    CSV.foreach(@file_path, headers: true) do |row|
      record = DiveCenter.new(
        name: row['name'],
        activities: row['type_flags']&.split(" "),
        longitude: row['longitude'],
        latitude: row['latitude'],
        city: row['city'],
        country_code: row['country'],
        phone_number: row['phone'],
        state: row['state'],
        street: row['street'],
        zip: row['zip'],
        email: row['email'],
        web_url: row['web_url']
      )

      if record.save
        puts "Record created: #{record.name}"
      else
        puts "Error creating record named '#{row['name']}': #{record.errors.full_messages.join(', ')}"
      end
    end
  end
  
  def import_with_gg_descriptions
    CSV.foreach(@file_path, headers: true) do |row|
      country = Country.find_by(name: row['name'])
      country.meta_description = row['meta_description']
      country.description = row['description']
      
      geo_groups = row['geo_groups'].split(", ")
      
      geo_groups.each do |str|
        geo_group = GeoGroup.find_by(name: str)
        
        unless geo_group.present?
          geocoded = Geocoder.search(str).first.data
          params = {
            name: str,
            latitude: geocoded["lat"],
            longitude: geocoded["lon"],
            bounding_box: geocoded["boundingbox"]
          }
          
          geo_group = GeoGroup.create!(params)
        end
        
        geo_group.countries << country
      end
      
      country.save
    end
  end
  
end