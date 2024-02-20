class DiveCentersActivity < ApplicationRecord
  
  # ============= callbacks ============
  
  after_create :increment_counters
  after_destroy :decrement_counters
  
  # ============= relations ==============
  
  belongs_to :dive_center
  belongs_to :activity
  
  # ============= methods ==============
  
  def increment_counters
    dive_centers = activity.dive_centers_count 
    activity.update(dive_centers_count: dive_centers + 1)
  end

  def decrement_counters
    dive_centers = activity.dive_centers_count 
    activity.update(dive_centers_count: dive_centers - 1)
  end
  
end