class Region < ApplicationRecord
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  reverse_geocoded_by :latitude, :longitude
  
  # ============= relations ============
  
  belongs_to :country, counter_cache: true
  has_many :cities
  has_many :dive_centers
  has_many :dive_sites

  # ============= validations ============
  
  validates :name, presence: true, length: { maximum: 255 }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }


  # ============= scopes ============


  # ============= methods ===========

  def geo_groups
    country.geo_groups
  end
  
  def waters
    geo_groups.water
  end
  
  def continent
    geo_groups.continent.first
  end

end
