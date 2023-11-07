class SitesController < ApplicationController
  
  def index
    @pagy, @sites = pagy(Site.all)
  end

  def show
    @site = Site.find(params[:id])
  end
  
end
