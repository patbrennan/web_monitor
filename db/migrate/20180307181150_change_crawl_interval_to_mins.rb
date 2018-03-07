class ChangeCrawlIntervalToMins < ActiveRecord::Migration[5.1]
  def change
    # rename_column :table_name, :old_column, :new_column
    rename_column :monitors, :crawl_interval_ms, :crawl_interval_mins
  end
end
