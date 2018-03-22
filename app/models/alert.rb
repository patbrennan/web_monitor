class Alert < ActiveRecord::Base
  has_many :user_alerts
  has_many :users, through: :user_alerts, dependent: :destroy
  has_many :crawls, dependent: :destroy
  
  before_save :activate # TODO: don't activate all alerts before save
  
  validate :valid_url? # Using custom method instead of valid url gem
  
  validates :crawl_interval_mins, presence: true, inclusion: {in: [10, 30, 60]}
  validates :notify_emails, presence: true, length: {minimum: 6}
  validates :name, presence: true, length: {minimum: 2}
  
  def activate
    self.active = true
  end
  
  def deactivate
    self.active = false
    UserMailer.alert_deactivated(self).deliver_later
  end
  
  # Return a hash corresponding to a Crawl's schema, to be used in creating
  # a new crawl record
  def crawl
    data = {}
    resp = nil
    
    time = Benchmark.measure do
      begin
        resp = HTTParty.get(self.url)
      rescue => e
        data = crawl_error_info(e)
      end
    end
    
    {
      alert_id: self.id,
      crawl_time: Time.now.to_s,
      resp_code: data[:resp_code] || resp.code,
      resp_time_ms: data[:resp_time_ms] || time.real * 1_000,
      resp_status: data[:resp_status] || resp.message,
      resp_size_kb: data[:resp_size_kb] || resp.size # TODO: convert to mb
    }
  end
  
  def valid_url?
    if !self.url.match(/^(((http|https):\/\/|)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?)$/i)
      errors.add(:url, "not valid")
    end
  end
  
  def crawl_error_info(e)
    if e.class == SocketError
      return {
        resp_code: 443,
        resp_time_ms: 0,
        resp_status: "NAME/SVC NOT KNOWN",
        resp_size_kb: 0 # TODO: convert to mb
      }
    end
  end
end