class Activity < ApplicationRecord

  # ============= relations ==============

  has_many :dive_centers_activities
  has_many :dive_centers, through: :dive_centers_activities

  # ============= validations ============

  validates :name, presence: true, length: { maximum: 255 }

end