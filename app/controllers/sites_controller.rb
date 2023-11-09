class SitesController < ApplicationController
  
  def index
    @pagy, @sites = pagy(Site.order(Arel.sql('country IS NULL, country')).all)
  end

  def show
    @site = Site.find(params[:id])
  end
  
end
