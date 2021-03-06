class User < ActiveRecord::Base
  has_secure_password
  
  has_many :user_alerts
  has_many :alerts, through: :user_alerts, dependent: :destroy
  
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 6}, on: :create
  
  def activate
    self.active = true
  end
  
  def deactivate
    self.active = false
  end
  
  def admin?
    self.role == "admin"
  end
  
  def to_param
    self.username
  end
  
  def valid_pw_token?(token)
    token && self.pw_reset_token == token
  end
  
  def token_expired?
    self.pw_reset_time + 1.hours < Time.now
  end
end