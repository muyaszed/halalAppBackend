class AddRatingToReview < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :rating, :integer, default: 0
  end
end
