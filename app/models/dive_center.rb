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
  validates :phone_number, allow_nil: true, format: {
    with: /\A\+?\d+(\s*[-\/()]*\s*\d+)*\z/,
    message: "must be a valid phone number"
  }, unless: -> { phone_number.nil? }
  
end
