class DiveCentersAffiliation < ApplicationRecord
  
  # ============= relations ==============
  
  belongs_to :dive_center
  belongs_to :affiliation
  
end