namespace :alerts do
  desc "log alerts."
  task :log_active => :environment do
    Alert.all.each do |alert|
      puts alert.name + ": " + alert.user.email
    end
  end
  
  desc "perform crawls"
  task :crawl_next => :environment do
    alerts = Alert.where(active: true)
    
    alerts.each do |alert|
      last_crawl_time = alert.crawls.last.crawl_time || Time.now
      
      if last_crawl_time < (Time.now + alert.crawl_interval_mins*60)
        crawl_stats = alert.crawl
        crawl_stats ? Crawl.create(crawl_stats) : alert.deactivate
        # TODO: send_deactivation_email
      end
    end
  end
end