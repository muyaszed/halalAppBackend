class AddUserIdToRestaurant < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :user_id, :integer
    add_foreign_key :restaurants, :users
  end
end
