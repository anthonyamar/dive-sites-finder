class GeoGroup < ApplicationRecord
  
  include AlgoliaSearch
  include Rails.application.routes.url_helpers
  extend FriendlyId
  friendly_id :name, use: :slugged
  reverse_geocoded_by :latitude, :longitude
  enum kind: { ocean: 'ocean', sea: 'sea', continent: 'continent' }

  # ============= relations ============
  
  has_one_attached :main_image
  
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
  
  def self.water
    self.ocean + self.sea
  end

  # ============= methods ===========
  
  
  # ============= algolia ===========
  
  algoliasearch do
    attributes :name, :full_path, :l_kind
    # later : add popularity score with 
    # customRaking ['desc(popularity_score)']
    
    geoloc :latitude, :longitude
  end
  
  def full_path
    geo_group_path(self)
  end
  
  def l_kind
    I18n.t("models.geo_groups.kinds.#{self.kind}").capitalize
  end

end
