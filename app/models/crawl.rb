class Crawl < ActiveRecord::Base
  belongs_to :alert
  
  after_save :update_alert_last_crawl
  
  def update_alert_last_crawl
    alert = self.alert
    alert.update(last_crawl: self.crawl_time)
  end
  
  def exceeds_limits?
    self.resp_time_ms > self.alert.response_time_threshold_ms
  end
  
  def errors
    self.resp_code != "200"
  end
end