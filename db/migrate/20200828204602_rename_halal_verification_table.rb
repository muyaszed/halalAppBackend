class RenameHalalVerificationTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :halal_verification, :halal_verifications
  end
end
