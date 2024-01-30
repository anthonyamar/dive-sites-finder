class RegionDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  
  def main_image_path
    placeholder = "illustrations/regions/placeholder.jpg"
    region.main_image.attached? ? region.main_image : placeholder
  end

end
