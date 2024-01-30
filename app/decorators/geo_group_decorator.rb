class GeoGroupDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  
  def format_countries_count(count: 4)
    countries = geo_group.countries.first(count).pluck(:name).join(' - ')
    countries_and_more = countries + " and #{geo_group.countries_count - count} more"
    geo_group.countries.size > count ? countries_and_more : countries
  end
  
  def main_image_path
    placeholder = "illustrations/geo_groups/placeholder.jpg"
    geo_group.main_image.attached? ? geo_group.main_image : placeholder
  end

end
