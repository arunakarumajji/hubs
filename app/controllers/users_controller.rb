class UsersController < ApplicationController
  before_action :authenticate_admin!, except: [:signup, :complete_signup]
  before_action :set_hub

  before_action :set_user, only: [:signup, :complete_signup]
  before_action :check_admin_permission, except: [:signup, :complete_signup]
  def index
    @users = @hub.users
  end

  def new
    @user = @hub.users.new
  end

  def create
    @user = @hub.users.new(user_params)
    @user.status = :pending
    if @user.save
      flash[:notice] = "User created successfully"
      redirect_to hub_users_path(@hub)
    else
      flash.now[:alert] = "Failed to create user"
      render :new, status: :unprocessable_entity
    end
  end

  def send_invites
    email_config_id = params[:email_config_id]
    email_config = @hub.email_configs.find_by(id: email_config_id)
    unless email_config
      redirect_to hub_users_path(@hub), alert: "Email configuration not found"
      return
    end
    # email_configs = @hub.email_configs.find(params[:email_config_id])
    users = @hub.users.pending
    if users.empty?
      redirect_to hub_users_path(@hub), alert: "No pending users to invite"
    else
      users.each do |user|
        UserMailer.with(user: user, email_config: email_config).invitation_email.deliver_now
      end
      flash[:notice] = "Invitations sent successfully"
      redirect_to hub_users_path(@hub)
    end

  end

  def signup
    redirect_to root_path, alert: "Invalid signup link" if @user.nil?
  end

  def complete_signup
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    # Create activity for new user signup
    Activity.create(
      action: Activity::USER_JOINED,
      user: @user,
      hub: @hub,
      data: { name: @user.full_name, email: @user.email }
    )
    session[:user_id] = @user.id
    if @user&.update(user_signup_params.merge(status: :active))
      redirect_to hub_user_challenges_path(@hub, @user) , notice: "Registration complete! You can now access the hub."
    else
      render :signup, status: :unprocessable_entity
    end
  end



  private

  def set_hub
    @hub = params[:hub_slug]? Hub.find_by(slug: params[:hub_slug]) : Hub.find(params[:hub_id])
    redirect_to root_path, alert: "Hub not found" unless @hub
  end

  def set_user
    @user = @hub.users.find_by(id: params[:user_id] || params[:id])
  end

  def check_admin_permission
    unless current_admin && current_admin.hub_id == @hub.id
      flash[:alert] = "You are not authorized to access this hub"
      redirect_to hubs_path
    end
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name)
  end

  def user_signup_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation)
  end
end
