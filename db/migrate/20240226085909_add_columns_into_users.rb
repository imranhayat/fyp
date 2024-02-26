class AddColumnsIntoUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :vehicle_type, :integer, default: 0
    add_column :users, :approved, :boolean, default: false
  end
end
