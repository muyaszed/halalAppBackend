class AddNewColumsToHalalVerifications < ActiveRecord::Migration[5.2]
  def change
    add_column :halal_verification, :certificate, :boolean, default: false
    add_column :halal_verification, :confirmation, :boolean, default: false
    add_column :halal_verification, :logo, :boolean, default: false
  end
end
