class DestinationCondition < ApplicationRecord
  
  # ============= relations ============
  
  belongs_to :destination
  
  # ============= validations ============
  
  validates :month, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 12 }
  validates :air_temperature, numericality: true, allow_blank: true
  validates :water_temperature, numericality: true, allow_blank: true
  validates :current_strength, inclusion: { in: 1..5 }, allow_blank: true
  validates :visibility_scale, inclusion: { in: 1..5 }, allow_blank: true
  
  # ============= scopes ============
end
