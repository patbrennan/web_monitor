class AddForgotPwToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :pw_reset_token, :string
    add_column :users, :pw_reset_time, :datetime
  end
end
