class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :enum
  end
end
