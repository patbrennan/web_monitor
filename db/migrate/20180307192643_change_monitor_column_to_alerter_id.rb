class ChangeMonitorColumnToAlerterId < ActiveRecord::Migration[5.1]
  def change
    rename_column :user_alerters, :monitor_id, :alerter_id
  end
end
