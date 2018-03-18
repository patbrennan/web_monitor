class SessionsController < ApplicationController
  def new; end
  
  def create
    @user = User.find_by(username: params[:username])
    
    if @user && @user.authenticate(params[:password]) && verify_recaptcha(model: @user)
      session[:user_id] = @user.id
      flash[:success] = "You're logged in"
      redirect_to user_alerts_path(@user)
    else
      flash[:error] = "Authentication Failed."
      redirect_to login_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "You've logged out."
    redirect_to root_path
  end
end