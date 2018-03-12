namespace :alerts do
  desc "log alerts."
  task :log_active => :environment do
    Alert.all.each do |alert|
      puts alert.name + ": " + alert.active.to_s
    end
  end
end