class GeoGroupDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  
  def format_countries_count(count: 4)
    countries = geo_group.countries.first(count).pluck(:name).join(' - ')
    countries + "and #{geo_group.countries_count - count} more" if geo_group.countries.size > count
  end

end
