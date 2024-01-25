class GeoGroup < ApplicationRecord
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  reverse_geocoded_by :latitude, :longitude
  enum kind: { water: 'water', continent: 'continent' }

  # ============= relations ============
  
  has_many :geo_groups_countries, dependent: :destroy
  has_many :countries, through: :geo_groups_countries
  
  has_many :regions, through: :countries
  has_many :cities, through: :regions
  has_many :dive_centers
  has_many :dive_sites

  # ============= validations ============
  
  validates :name, presence: true, length: { maximum: 255 }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :kind, presence: true, inclusion: { in: kinds.keys }


  # ============= scopes ============


  # ============= methods ===========

end