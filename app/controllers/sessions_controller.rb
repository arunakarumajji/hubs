class SessionsController < ApplicationController
  def new

  end

  def create
    admin = Admin.find_by(email: params[:email])
    if admin && admin.authenticate(params[:password])
      session[:admin_id] = admin.id
      flash[:notice] = "Logged in successfully"
      redirect_to root_path
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:admin_id] = nil
    flash[:notice] = "Logged out successfully"
    redirect_to login_path
  end


end
