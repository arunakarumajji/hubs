class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_admin, :admin_logged_in?, :current_user, :user_logged_in?

  private

  def current_admin
    @current_admin ||= Admin.find_by(id: session[:admin_id]) if session[:admin_id]
  end


  #true if an admin is logged in (current_admin exists)
  #false if no admin is logged in (current_admin is nil)
  def admin_logged_in?
    !!current_admin
  end

  def authenticate_admin!
    unless admin_logged_in?
      flash[:alert] = "You must be logged in to access this section"
      redirect_to login_path
    end
  end


  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def user_logged_in?
    !!current_user
  end

  def authenticate_user!
    unless user_logged_in?
      flash[:alert] = "You must be logged in to access this section"
      redirect_to user_login_path
    end
  end


end
