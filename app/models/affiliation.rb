class Affiliation < ApplicationRecord
  
  # ============= relations ==============

  has_many :dive_centers_affiliations
  has_many :dive_centers, through: :dive_centers_affiliations

  # ============= validations ============

  validates :name, presence: true, length: { maximum: 255 }

end
