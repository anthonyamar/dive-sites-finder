class Prestation < ApplicationRecord

  # ============= relations ==============

  has_many :dive_centers_prestations
  has_many :dive_centers, through: :dive_centers_prestations

  # ============= validations ============

  validates :name, presence: true, length: { maximum: 255 }

end