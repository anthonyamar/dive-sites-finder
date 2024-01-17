class GeoGroupsCountry < ApplicationRecord
  
  # ============= relations ============
  
  belongs_to :geo_group
  belongs_to :country
  
end
