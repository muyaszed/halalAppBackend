class RemoveColumnFromRestaurant < ActiveRecord::Migration[5.2]
  def change
    remove_column :restaurants, :location
    add_column :restaurants, :address, :string
    add_column :restaurants, :city, :string
    add_column :restaurants, :postcode, :string
    add_column :restaurants, :country, :string
  end
end
