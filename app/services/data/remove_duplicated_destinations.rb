require 'csv'

class Data::RemoveDuplicatedDestinations
  
  attr_reader :counter
  
  MERGED = []
  
  def initialize
    @counter = 0
    Destination.find_each do |destination|
      perform(destination)
    end
    
    create_csv_from_arrays
  end
  
  def perform(destination)
    attributes_to_merge = %w[water_type water_specific timezone languages latitude longitude]
    
    duplicates = Destination
      .where(country: destination.country, region: destination.region, city: destination.city)
      .where.not(id: destination.id)
    
    duplicates.find_each do |duplicate|
      # Mettre à jour les références d'autres tables si nécessaire
      DiveSite.where(destination_id: duplicate.id).update_all(destination_id: destination.id)
      DiveCenter.where(destination_id: duplicate.id).update_all(destination_id: destination.id)
      
      # Fusionner les attributs
      attributes_to_merge.each do |attribute|
        if duplicate[attribute].present? && destination[attribute].nil?
          destination.update_attribute(attribute, duplicate[attribute])
        end
      end

      # Supprimer le doublon
      if duplicate.destroy!
        @counter += 1
        puts @counter
      end
    end
    
    MERGED << destination if destination.save
  end
  
  def create_csv_from_arrays
    arrays = {
      merged_destinations: MERGED,
    }
    
    arrays.each do |key, value|
      filename = Rails.public_path.join("remove_duplicated_destinations", "#{key}.csv").to_s
      write_to_csv(filename, value)
    end
  end
  
  def write_to_csv(filename, data)
    CSV.open(filename, "wb") do |csv|
      # En-têtes du fichier CSV
      csv << %w(ID city region country country_code latitude longitude)

      # Écriture des données
      data.each do |dest|
        row = [
          dest.id,
          dest.city,
          dest.region,
          dest.country,
          dest.country_code,
          dest.latitude,
          dest.longitude
        ]
        
        csv << row
      end
    end
  end
  
end