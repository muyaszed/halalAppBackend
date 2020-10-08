class ChangeContactNumberName < ActiveRecord::Migration[5.2]
  def change
    remove_column :restaurants, :contactNumber
    add_column :restaurants, :contact_number, :string
  end
end
