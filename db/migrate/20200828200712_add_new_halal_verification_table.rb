class AddNewHalalVerificationTable < ActiveRecord::Migration[5.2]
  def change
    create_table :halal_verification do |t|
      t.belongs_to :user, index: true
      t.belongs_to :restaurant, index: true
      t.timestamps
    end
  end
end
