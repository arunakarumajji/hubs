class EmailConfigsController < ApplicationController

  before_action :authenticate_admin!
  before_action :set_hub
  before_action :set_email_config, only: [:edit, :update]
  before_action :check_admin_permission
  def new
    @email_config = @hub.email_configs.new
  end

  def create
      @email_config = @hub.email_configs.new(email_config_params)
      if @email_config.save
        redirect_to hub_path(@hub), notice: "Email configuration created successfully"
      else
        render :new, status: :unprocessable_entity
      end
  end

  def edit
    # Add this method to fix the missing action
    # This empty action will render the edit view
  end

  def update

    if @email_config.update(email_config_params)
      redirect_to hub_path(@hub), notice: "Email configuration updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_hub
    @hub = Hub.find(params[:hub_id])
  end

  def set_email_config
    @email_config = @hub.email_configs.find(params[:id])
  end

  def check_admin_permission
    unless current_admin.hub_id == @hub.id
      flash[:alert] = "You are not authorized to access this hub"
      redirect_to hubs_path
    end
  end

  def email_config_params
    params.require(:email_config).permit(:subject, :body, :from_email)
  end
end
