class Affiliation < ApplicationRecord
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  # ============= relations ==============

  has_many :dive_centers_affiliations
  has_many :dive_centers, through: :dive_centers_affiliations

  # ============= validations ============

  validates :name, presence: true, length: { maximum: 255 }
  validates :slug, presence: true, length: { maximum: 255 }
  
  # ============= methods ================
  
  def should_generate_new_friendly_id?
    name_changed? || super
  end

end
