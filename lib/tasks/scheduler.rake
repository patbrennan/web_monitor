desc "perform crawls for active alerts if their interval has passed"
task :crawl_next => :environment do
  alerts = Alert.where(active: true).includes(:crawls)
  
  alerts.each do |alert|
    last = alert.crawls.last
    
    last_crawl_time = last.crawl_time if !last.nil?
      
    if last.nil? ||
       (last_crawl_time + alert.crawl_interval_mins*60) < Time.now + 1
      crawl_stats = alert.crawl
    end
    
    if crawl_stats
      crawl = Crawl.new(crawl_stats)
      crawl.save
    
      if crawl.exceeds_limits? || crawl.bad_resp_code?
        UserMailer.crawl_alert(alert, crawl).deliver_later
      end
    else
      alert.deactivate
    end
  end
end