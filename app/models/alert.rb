class Alert < ActiveRecord::Base
  has_many :user_alerts
  has_many :users, through: :user_alerts
  has_many :crawls, dependent: :destroy
  
  before_save :activate
  
  validate :valid_url? # Using custom method instead of valid url gem
  
  validates :crawl_interval_mins, presence: true, inclusion: {in: [10, 30, 60]}
  validates :notify_emails, presence: true, length: {minimum: 6}
  validates :name, presence: true, length: {minimum: 2}
  
  def activate
    self.active = true
  end
  
  def deactivate
    self.active = false
  end
  
  def crawl
    resp = nil
    
    time = Benchmark.measure do
      resp = HTTParty.get(self.url)
    end
    
    {
      alert_id: self.id,
      crawl_time: Time.now,
      resp_code: resp.code,
      resp_time_ms: time.real * 1_000,
      resp_status: resp.message,
      resp_size_kb: resp.size # TODO: convert to mb
    }.to_json
  end
  
  def valid_url?
    if !self.url.match(/^(((http|https):\/\/|)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?)$/i)
      errors.add(:url, "not valid")
    end
  end
end