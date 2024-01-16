class Country < ApplicationRecord
  
  reverse_geocoded_by :latitude, :longitude
  
  # ============= relations ============
  
  belongs_to :geo_group
  has_many :regions
  has_many :cities, through: :regions
  has_many :dive_centers
  has_many :dive_sites

  # ============= validations ============
  
  validates :name, presence: true, length: { maximum: 255 }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :phone_prefix, format: { with: /\A\+\d+\z/, message: "should start with '+' followed by numbers" }
  validates :code, format: { with: /\A[A-Z]{2}\z/, message: "should be 2 upcase letters" }

  # ============= scopes ============


  # ============= methods ===========

end
