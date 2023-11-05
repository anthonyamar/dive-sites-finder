class SitesController < ApplicationController
  
  def index
    @sites = Site.first(10)
  end

  def show
  end
  
end
