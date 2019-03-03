class AddColumnToRestaurant < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :cuisine, :string
    add_column :restaurants, :web, :string
    add_column :restaurants, :start, :string
    add_column :restaurants, :end, :string
  end
end
