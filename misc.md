*= require_tree .
*= require_self
 
## Cron Jobs / Schedulers
 
- Job runs every 10 mins
```ruby
# cron every 10 mins

# @alerts = Alert.where(active: true) # get list of crawls as well?
# iterate through each
# if alert.last_crawl < time.now + (alert.crawl_int_mins * 60)
# crawl_stats = alert.crawl
# Crawl.create(crawl_stats)
```

TODO:
<!--1. create rake tasks-->
<!--2. edit view 10/30/60 mins intervals select-->
<!--3. normalize urls method & validate-->
<!--4. edit / delete icons-->
<!--5. user_alerts view: better status, created, last crawl time, date format-->
<!--3. edit interface: better tables-->
<!--3. Get tasks up & running on heroku-->
<!--5. learn: obscure keys / keep secret-->
6. Add google captcha to registration page
4. integrate email service
5. approve users email
6. alert emails
7. Move to AWS c9 to implement headless browser/Watir testing & performance nums