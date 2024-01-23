class GeoGroupsController < ApplicationController
  
  def index
    @geo_groups = GeoGroup.all
  end
  
end
