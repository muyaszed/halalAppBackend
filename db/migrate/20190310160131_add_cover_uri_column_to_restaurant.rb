class AddCoverUriColumnToRestaurant < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :cover_uri, :string
  end
end
