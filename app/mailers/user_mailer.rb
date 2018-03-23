class UserMailer < ApplicationMailer
  def confirm_email(user)
    @user = user
    @hash = BCrypt::Password.create(@user.email + Rails.application.secrets.sitch_key)
    
    mail(to: @user.email, subject: "Confirm Your Email for theSitch.")
  end
  
  def password_email(user)
    @user = user
    
    mail(to: @user.email, subject: "Reset Your Password")
  end
  
  def crawl_alert(alert, crawl)
    @alert = alert
    @crawl = crawl
    
    mail(to: @user.email, subject: "ALERT FOR #{@alert.name}. We've detected issues.")
  end
  
  def alert_deactivated(alert)
    @alert = alert
    @user = alert.user
    
    mail(to: @user.email, subject: "Your Alert Has Been Deactivated")
  end
  
  def account_activated(user)
    @user = user
    
    mail(to: @user.email, subject: "Your Account has Been Approved")
  end
end