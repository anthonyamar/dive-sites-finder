class Destination < ApplicationRecord
  
  # ============= relations ============
  
  has_many :dive_sites
  has_many :dive_centers
  has_many :destination_conditions
  
  # ============= validations ============
  
  validates :name, presence: true
  validates :country, presence: true
  validates :country_code, presence: true
  
  # ============= scopes ============
  
end
