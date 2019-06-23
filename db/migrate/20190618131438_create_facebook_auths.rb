class CreateFacebookAuths < ActiveRecord::Migration[5.2]
  def change
    create_table :facebook_auths do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.string :email
      t.string :uid
      t.string :oauth_token
      t.string :fb_avatar

      t.timestamps
    end
  end
end
