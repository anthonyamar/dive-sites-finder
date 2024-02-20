class Activity < ApplicationRecord
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  # ============= relations ==============

  has_many :dive_centers_activities
  has_many :dive_centers, through: :dive_centers_activities

  # ============= validations ============

  validates :name, presence: true, length: { maximum: 255 }
  validates :slug, presence: true, length: { maximum: 255 }
  
  # ============= scopes =================
  
  scope :visible, -> { joins(:dive_centers_activities).where(dive_centers_activities: { visible: true }).distinct }

  
  # ============= methods ================
  
  def should_generate_new_friendly_id?
    name_changed? || super
  end

end