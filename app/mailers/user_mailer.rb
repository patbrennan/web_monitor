class UserMailer < ApplicationMailer
  def confirm_email(user)
    @user = user
    @hash = BCrypt::Password.create(@user.email + Cred.find("sitch_key"))
    
    mail(to: @user.email, subject: "Confirm Your Email for theSitch.")
  end
end