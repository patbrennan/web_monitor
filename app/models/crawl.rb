class Crawl < ActiveRecord::Base
  belongs_to :alert
  
  def crawl
    resp = {}
    
    time = Benchmark.measure do
      resp = HTTParty.get(@url)
    end
    
    {
      crawl_time: Time.now,
      resp_code: resp.code,
      resp_time_ms: time.real,
      resp_status: resp.message,
      resp_size_kb: resp.size # TODO: convert to mb
    }
  end
end