class AddColumnContactNumberToRestaurant < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :contactNumber, :string
  end
end
