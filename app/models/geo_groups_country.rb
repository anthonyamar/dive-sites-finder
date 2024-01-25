class GeoGroupsCountry < ApplicationRecord
  
  # ============= callbacks ============
  
  after_create :increment_counters
  after_destroy :decrement_counters
  
  # ============= relations ============
  
  belongs_to :geo_group
  belongs_to :country
  
  # ============= methods ==============
  
  def increment_counters
    countries = geo_group.countries_count 
    geo_group.update(:countries_count, countries + 1)
  end

  def decrement_counters
    countries = geo_group.countries_count 
    geo_group.update(:countries_count, countries - 1)
  end
  
end
