class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :integer
    change_column :users, :role, :integer, :default => 1
  end
end
