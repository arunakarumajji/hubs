class ActivitiesController < ApplicationController

  before_action :set_hub

  def index
    @activities = @hub.activities.recent.includes(:user, :trackable).page(params[:page]).per(20)
  end

  private
  def set_hub
    @hub = Hub.find(params[:hub_id])
  end
end