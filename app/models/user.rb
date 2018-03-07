class User < ActiveRecord::Base
  has_secure_password
  
  has_many :user_alerts
  has_many :alerts, through: :user_alerts
  
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 6}
end