class AddPhotoUriToReview < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :photo_uri, :string
  end
end
