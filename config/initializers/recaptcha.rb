# config/initializers/recaptcha.rb
Recaptcha.configure do |config|
  config.site_key  = Cred.find("captcha_site_key")
  config.secret_key = Cred.find("captcha_secret_key")
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
end