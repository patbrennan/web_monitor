class Alert < ActiveRecord::Base
  has_many :user_alerts
  has_many :users, through: :user_alerts
  
  validates :url, presence: true
  validates :crawl_interval_mins, presence: true, default: 60
  validates :notify_emails, presence: true
  validates :name, presence: true
end