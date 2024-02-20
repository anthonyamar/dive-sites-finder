class DiveCentersActivity < ApplicationRecord
  
  # ============= relations ==============
  
  belongs_to :dive_center
  belongs_to :activity
  
end