class City < ApplicationRecord
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  reverse_geocoded_by :latitude, :longitude
  
  # ============= callbacks ============
  
  after_create :increment_country_counter # Counter cache de country has_many city through region
  after_destroy :decrement_country_counter
  
  # ============= relations ============
  
  has_one_attached :main_image
  
  belongs_to :region, counter_cache: true
  has_many :dive_centers
  has_many :dive_sites

  # ============= validations ============
  
  validates :name, presence: true, length: { maximum: 255 }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }


  # ============= scopes ============


  # ============= methods ===========
  
  def country
    region.country
  end
  
  def geo_groups
    country.geo_groups
  end
  
  def waters
    geo_groups.water
  end
  
  def continent
    geo_groups.continent.first
  end
  
  private
  
  def increment_country_counter
    country = self.country
    country.update_columns(cities_count: country.cities_count + 1)
  end

  def decrement_country_counter
    country = self.country
    country.update_columns(cities_count: country.cities_count - 1)
  end

end
