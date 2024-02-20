class DiveCentersAffiliation < ApplicationRecord
  
  # ============= callbacks ============
  
  after_create :increment_counters
  after_destroy :decrement_counters
  
  # ============= relations ==============
  
  belongs_to :dive_center
  belongs_to :affiliation
  
  # ============= methods ==============
  
  def increment_counters
    dive_centers = affiliation.dive_centers_count 
    affiliation.update(dive_centers_count: dive_centers + 1)
  end

  def decrement_counters
    dive_centers = affiliation.dive_centers_count 
    affiliation.update(dive_centers_count: dive_centers - 1)
  end
  
end