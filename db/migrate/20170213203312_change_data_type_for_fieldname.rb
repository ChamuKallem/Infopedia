class ChangeDataTypeForFieldname < ActiveRecord::Migration
  def change
    change_column :users, :stripe_id, :string
  end
end
