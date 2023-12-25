class Destination < ApplicationRecord
  
  geocoded_by :full_address
  after_validation :geocode
  
  # ============= relations ============
  
  has_many :dive_sites
  has_many :dive_centers
  has_many :destination_conditions
  
  # ============= validations ============
  
  validates :country, presence: true
  validates :country_code, presence: true
  
  # ============= scopes ============
  
  # ============= methods ===========
  
  def name
    if city
      return city
    elsif city.blank? && region
      return region
    else
      return country
    end
  end
  
  def full_address
    [city, region, country].compact.join(', ')
  end
  
end
