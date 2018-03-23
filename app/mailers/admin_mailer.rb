class AdminMailer < ApplicationMailer
  ADMIN = "patrick@junecommerce.org".freeze
    
  def approve(user)
    @user = user
    @hash = BCrypt::Password.create(@user.username + Rails.application.secrets.sitch_key)
    
    mail(to: ADMIN, subject: "theSitch: New User Requesting Access")
  end
end