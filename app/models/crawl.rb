class Crawl < ActiveRecord::Base
  belongs_to :alert
  
  after_save :update_alert_last_crawl
  
  def update_alert_last_crawl
    alert = self.alert
    alert.update(last_crawl: self.crawl_time)
  end
end