class CityDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  
  def main_image_path
    placeholder = "illustrations/cities/placeholder.jpg"
    city.main_image.attached? ? city.main_image : placeholder
  end

end
