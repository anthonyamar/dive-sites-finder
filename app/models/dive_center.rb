class DiveCenter < ApplicationRecord
  
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :web_url, allow_nil: true, length: { maximum: 255 }, format: { with: URI::DEFAULT_PARSER.make_regexp }, unless: -> { web_url.nil? }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :street, presence: true, length: { maximum: 255 }
  validates :city, presence: true, length: { maximum: 255 }
  validates :state, allow_nil: true, length: { maximum: 255 }, unless: -> { state.nil? }
  validates :zip, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :country_code, presence: true, length: { is: 2 }
  validates :activities, array: { presence: true }
  validates :phone_number, allow_nil: true, format: { with: /\A\+?\d+\z/, message: "only allows digits and an optional leading plus sign" }, unless: -> { phone_number.nil? }
  
end
