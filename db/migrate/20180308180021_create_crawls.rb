class CreateCrawls < ActiveRecord::Migration[5.1]
  def change
    create_table :crawls do |t|
      t.integer :alert_id
      t.datetime :crawl_time
      t.string :resp_code, :resp_status
      t.integer :resp_time_ms, :resp_size_kb
    end
  end
end
