class Site < ApplicationRecord
  enum bow: { salt: 'salt', artificial: 'artificial', fresh: 'fresh' }

  validates :name, presence: true, length: { maximum: 90 }
  validates :bow, presence: true, inclusion: { in: bows.keys }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :address, presence: true, length: { maximum: 255 }
  validates :region, presence: true, length: { maximum: 255 }
  validates :country, presence: true, length: { maximum: 255 }
  validates :is_private, inclusion: { in: [true, false] }
end
