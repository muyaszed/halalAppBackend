class RemoveAddressColumnFromRestaurant < ActiveRecord::Migration[5.2]
  def change
    remove_column :restaurants, :address
  end
end
