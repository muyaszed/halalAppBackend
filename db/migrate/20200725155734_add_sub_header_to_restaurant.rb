class AddSubHeaderToRestaurant < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :sub_header, :string
  end
end
