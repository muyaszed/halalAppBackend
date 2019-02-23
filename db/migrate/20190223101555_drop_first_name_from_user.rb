class DropFirstNameFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
    add_column :profiles, :first_name, :string
    add_column :profiles, :last_name, :string
  end
end
