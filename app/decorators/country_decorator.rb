class CountryDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  
  def main_image_path
    placeholder = "illustrations/countries/placeholder.jpg"
    country.main_image.attached? ? country.main_image : placeholder
  end

end
