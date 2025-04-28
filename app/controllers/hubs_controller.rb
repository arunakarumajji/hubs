class HubsController < ApplicationController

  before_action :authenticate_admin!, except: [:index, :show, :new, :create]
  before_action :set_hub, only: [:show, :edit, :update]
  def index
    @hubs = Hub.all
  end

  def show
    @users = @hub.users if admin_logged_in? && current_admin.hub_id == @hub.id
  end

  def new
    @hub = Hub.new
  end

  def create
    @hub = Hub.new(hub_params)
    if @hub.save
      flash[:notice] = "Hub created successfully"
      redirect_to new_hub_admin_path(@hub)
    else
      flash.now[:alert] = "Failed to create hub"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    unless current_admin.hub_id == @hub.id
      flash[:alert] = "You are not authorized to edit this hub"
      redirect_to hubs_path
    end


  end

  def update
    unless current_admin.hub_id == @hub.id
      flash[:alert] = "You are not authorized to edit this hub"
      redirect_to hubs_path
    end

    if @hub.update(hub_params)
      redirect_to hub_path(@hub), notice: "Hub updated successfully"
    else
      flash.now[:alert] = "Failed to update hub"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_hub
    @hub = Hub.find(params[:id])
  end

  def hub_params
    params.require(:hub).permit(:name, :description)
  end
end
