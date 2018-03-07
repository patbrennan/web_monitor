class ChangeAlertersToAlerts < ActiveRecord::Migration[5.1]
  def change
    rename_column :user_alerters, :alerter_id, :alert_id
    rename_table :alerters, :alerts
    rename_table :user_alerters, :user_alerts
  end
end
