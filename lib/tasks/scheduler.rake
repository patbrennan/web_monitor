desc "perform crawls"
task :crawl_next => :environment do
  alerts = Alert.where(active: true).includes(:crawls)
  
  alerts.each do |alert|
    last = alert.crawls.last
    
    if !last.nil?
      last_crawl_time = last.crawl_time
    end
    
    if (last.nil?) ||
       ((last_crawl_time + alert.crawl_interval_mins*60) < Time.now)
      crawl_stats = alert.crawl
      crawl_stats ? Crawl.create(crawl_stats) : alert.deactivate
      # TODO: send_deactivation_email
    end
  end
end