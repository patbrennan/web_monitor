class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_user, except: [:new, :create, :confirm]
  before_action :require_same_user, only: [:edit, :update]
  # before_action :verify_recaptcha, only: [:create]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if verify_recaptcha(model: @user) && @user.save
      UserMailer.confirm_email(@user).deliver_later
      flash[:success] = "Registration requested. Please verify your email address, and wait for approval."
      redirect_to login_path
    else
      render :new
    end
  end
  
  def show; end
  
  def edit; end
  
  def update
    if @user && @user.update(user_params)
      flash[:success] = "Updated Profile for #{@user.username}"
      redirect_to :back
    elsif !@user
      flash[:error] = "User not found"
      redirect_to root_path
    else
      render :edit
    end
  end
  
  def confirm
    @user = User.find_by(username: params[:user_id])
    str = @user.email + Cred.find("sitch_key")
    @confirmed = BCrypt::Password.new(params[:conf_id]) == str
    
    @user.update(email_confirmed: true) if @confirmed
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :email, :time_zone, :password)
  end
  
  def set_user
    @user = User.find_by(username: params[:id])
  end
end