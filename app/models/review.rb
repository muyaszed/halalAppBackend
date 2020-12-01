class Review < ApplicationRecord
    validates :comment, presence:, rating: true
    belongs_to :restaurant
    belongs_to :user
    has_one_attached :photo
end
