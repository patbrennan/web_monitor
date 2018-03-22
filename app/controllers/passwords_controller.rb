class PasswordsController < ApplicationController
  before_action :set_user, only: [:reset, :update]
  
  def forgot # GET /password/forgot
  end
  
  def reset # POST /password/reset
    if @user
      @user.pw_reset_token = SecureRandom.hex(10)
      @user.pw_reset_time = Time.now
      
      if @user.save
        flash[:success] = "Password reset email sent."
        UserMailer.password_email(@user).deliver_later
        redirect_to root_path
      else
        flash[:error] = "Something went wrong. Please try again."
        redirect_to password_forgot_path
      end
    else
      flash[:error] = "Email not found."
      render :forgot
    end
  end
  
  def edit # GET /password/edit
  end
  
  def update # PUT /password/update
    if @user && @user.valid_pw_token?(params[:reset_token])
      if @user.token_expired?
        flash[:error] = "Password reset token expired. Please reset your password again."
        redirect_to password_reset_path
      else
        @user.update({
          password: params[:password],
          pw_reset_token: SecureRandom.hex(10),
          pw_reset_time: Time.now
        })
        flash[:success] = "Password Updated."
        redirect_to login_path
      end
    else
      flash[:error] = "Incorrect information. Please try again."
      render :edit
    end
  end
  
  private
  
  def set_user
    @user = User.find_by(email: params[:email])
  end
end