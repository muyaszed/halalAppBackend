class DromImgur < ActiveRecord::Migration[5.2]
  def change
    drop_table :active_storage_imgur_key_mappings
  end
end
