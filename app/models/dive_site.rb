class DiveSite < ApplicationRecord
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  reverse_geocoded_by :latitude, :longitude
  enum bow: { salt: 'salt', artificial: 'artificial', fresh: 'fresh', unknown: 'unknown' }
  
  # ============= relations ==============
  
  belongs_to :destination, counter_cache: true, optional: true
  belongs_to :geo_group, counter_cache: true, optional: true
  belongs_to :country, counter_cache: true, optional: true
  belongs_to :region, counter_cache: true, optional: true
  belongs_to :city, counter_cache: true, optional: true
  
  # ============= validations ============
  
  validates :name, presence: true, length: { maximum: 255 }
  validates :bow, presence: true, inclusion: { in: bows.keys }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :address, length: { maximum: 255 }, allow_blank: true
  validates :region, length: { maximum: 255 }, allow_blank: true
  validates :country, length: { maximum: 255 }, allow_blank: true
  validates :is_private, inclusion: { in: [true, false] }
  
  # =============== scope ================

  
end
