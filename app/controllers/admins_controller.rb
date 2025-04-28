class AdminsController < ApplicationController

  before_action :set_hub
  def new
    @admin = @hub.admins.new
  end

  def create
    @admin = @hub.admins.new(admin_params)
    if @admin.save
      flash[:notice] = "Admin created successfully"
      redirect_to hub_path(@hub)
    else
      flash.now[:alert] = "Failed to create admin"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_hub
    @hub = Hub.find(params[:hub_id])
  end

  def admin_params
    params.require(:admin).permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end
end
