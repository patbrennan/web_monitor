class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username, :email, :password_digest, :time_zone, :role
      t.timestamps
      t.boolean :active
    end
  end
end
