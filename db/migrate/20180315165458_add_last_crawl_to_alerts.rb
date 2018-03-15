class AddLastCrawlToAlerts < ActiveRecord::Migration[5.1]
  def change
    add_column :alerts, :last_crawl, :datetime
  end
end
