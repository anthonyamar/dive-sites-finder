class Region < ApplicationRecord
  
  include AlgoliaSearch
  include Rails.application.routes.url_helpers
  extend FriendlyId
  friendly_id :name, use: :slugged
  reverse_geocoded_by :latitude, :longitude
  
  # ============= relations ============
  
  has_one_attached :main_image
  
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
    geo_groups.waters
  end
  
  def continent
    geo_groups.continent.first
  end
  
  # ============= algolia ===========
  
  algoliasearch do
    attributes :name, :full_path, :l_kind, :l_geo_refs
    searchableAttributes ['name']
    
    # later : add popularity score with 
    # customRanking ['desc(popularity_score)']
    
    geoloc :latitude, :longitude
  end
  
  def full_path
    region_path(region: self, country: self.country)
  end
  
  def l_kind
    I18n.t("models.regions.kinds.region").capitalize
  end
  
  def l_geo_refs
    I18n.t("models.regions.geo_refs", country: self.country.name)
  end

end
