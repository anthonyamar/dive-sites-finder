class GeoGroupsController < ApplicationController

  before_action :set_geo_group, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :must_be_admin, only: [:edit, :update]

  def index
    @geo_groups = GeoGroup.all
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @geo_group.update(geo_group_params)
        format.html { redirect_to @geo_group, notice: "#{@geo_group.name} has been successfuly updated." }
        format.json { render :show, status: :ok, location: @geo_group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @geo_group.errors, status: :unprocessable_entity }
      end
    end
  end

  private 

  def set_geo_group
    @geo_group = GeoGroup.friendly.find(params[:id]).decorate
  end

  def must_be_admin
    current_user.admin?
  end

  def geo_group_params
    params.require(:geo_group).permit(:name, :description, :latitude, :longitude, :kind, :slug)
  end

end
