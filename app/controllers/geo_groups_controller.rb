class GeoGroupsController < ApplicationController
  
  def index
    @geo_groups = GeoGroup.all
  end
  
  def show
    @geo_group = GeoGroup.find(params[:id])
  end
  
end
