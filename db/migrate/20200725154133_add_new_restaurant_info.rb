class AddNewRestaurantInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :family_friendly, :boolean
    add_column :restaurants, :surau, :boolean
    add_column :restaurants, :disabled_accessibility, :boolean
  end
end
