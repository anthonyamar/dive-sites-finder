class Country < ApplicationRecord
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  reverse_geocoded_by :latitude, :longitude
  
  # ============= relations ============
  
  has_one_attached :main_image
  
  has_many :geo_groups_countries, dependent: :destroy
  has_many :geo_groups, through: :geo_groups_countries
  
  has_many :regions
  has_many :cities, through: :regions
  has_many :dive_centers
  has_many :dive_sites

  # ============= validations ============
  
  validates :name, presence: true, length: { maximum: 255 }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :phone_prefix, format: { with: /\A\+\d+\z/, message: "should start with '+' followed by numbers" }, allow_blank: true
  validates :code, format: { with: /\A[A-Z]{2}\z/, message: "should be 2 upcase letters" }

  # ============= scopes ============


  # ============= methods ===========
  
  def waters
    geo_groups.water
  end
  
  def continent
    geo_groups.continent.first
  end

end
