module ApplicationHelper
  def format_date(datestring)
    datestring.strftime("%m/%d/%y")
  end
  
  def format_crawl_time(datestring)
    return "Pending" unless datestring
    datestring.strftime("%m/%d/%y, %H:%M %Z")
  end
  
  def format_crawl_status(alert_obj)
    
  end
  
  def last_crawl_status(alert)
    return "warn" if alert.crawls.empty?
    
    status = alert.crawls.last.status
    
    case status
    when "OK"
      "good"
    when !"OK"
      "bad"
    else
    end
  end
end
