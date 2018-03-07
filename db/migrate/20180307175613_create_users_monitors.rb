class CreateUsersMonitors < ActiveRecord::Migration[5.1]
  def change
    create_table :users_monitors do |t|
      t.integer :user_id
      t.integer :monitor_id
    end
  end
end
