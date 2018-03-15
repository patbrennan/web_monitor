class Crawl < ActiveRecord::Base
  belongs_to :alert
  
  after_save :update_alert_last_crawl
  
  def update_alert_last_crawl
    self.alert.last_crawl = self.crawl_time
    self.alert.update
  end
end