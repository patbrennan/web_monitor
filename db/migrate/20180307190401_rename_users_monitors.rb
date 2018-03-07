class RenameUsersMonitors < ActiveRecord::Migration[5.1]
  def change
    rename_table :users_monitors, :user_monitors
  end
end
