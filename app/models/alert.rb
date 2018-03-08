class Alert < ActiveRecord::Base
  has_many :user_alerts
  has_many :users, through: :user_alerts
  
  before_save :activate
  
  validates :url, presence: true
  validates :crawl_interval_mins, presence: true
  validates :notify_emails, presence: true, length: {minimum: 6}
  validates :name, presence: true, length: {minimum: 2}
  
  def activate
    self.active = true
  end
  
  def deactivate
    self.active = false
  end
end