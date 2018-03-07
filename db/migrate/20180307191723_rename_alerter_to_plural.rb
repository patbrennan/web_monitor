class RenameAlerterToPlural < ActiveRecord::Migration[5.1]
  def change
    rename_table :alerter, :alerters
  end
end
