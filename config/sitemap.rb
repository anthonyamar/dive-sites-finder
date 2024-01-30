require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://example.com'
SitemapGenerator::Sitemap.create do
  add '/home', priority: 0.9
  add '/about', priority: 0.5
  
  DiveSite.find_each do |dive_site|
    add "/dive_sites/#{dive_site.slug}", priority: 0.7
  end
  
  DiveCenter.find_each do |dive_center|
    add "/dive_centers/#{dive_center.slug}", priority: 0.8
  end
  
  add "/geo_groups"
  GeoGroup.find_each do |geo_group|
    add "/geo_groups/#{geo_group.slug}", priority: 0.9
  end
  
  Country.find_each do |country|
    add "/countries/#{country.slug}", priority: 1
  end
  
  Region.find_each do |region|
    add "/#{region.country.slug}/#{region.slug}", priority: 1
  end
  
  City.find_each do |city|
    add "/#{city.country.slug}/#{city.region.slug}/#{city.slug}", priority: 1
  end
  
end

# Not needed if you use the rake tasks 
# SitemapGenerator::Sitemap.ping_search_engines 