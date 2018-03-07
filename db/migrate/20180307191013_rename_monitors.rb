class RenameMonitors < ActiveRecord::Migration[5.1]
  def change
    rename_table :monitors, :alerter
  end
end
