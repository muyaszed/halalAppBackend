class CreateUserAppleAuths < ActiveRecord::Migration[5.2]
  def change
    create_table :user_apple_auths do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.string :email
      t.string :uid
      t.string :auth_code
      t.timestamps
    end
  end
end
