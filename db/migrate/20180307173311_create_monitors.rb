class CreateMonitors < ActiveRecord::Migration[5.1]
  def change
    create_table :monitors do |t|
      t.string :url, :name, :current_status, :notify_emails
      t.integer :crawl_interval_ms, :response_time_threshold_ms
      t.boolean :active
      t.timestamps
    end
  end
end
