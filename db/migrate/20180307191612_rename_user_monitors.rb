class RenameUserMonitors < ActiveRecord::Migration[5.1]
  def change
    rename_table :user_monitors, :user_alerters
  end
end
