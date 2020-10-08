class AddSocMedColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :soc_med, :jsonb, null: false, default: '{}'
  end
end
