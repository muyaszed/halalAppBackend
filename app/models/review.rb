class Review < ApplicationRecord
    validates :comment, presence: true
    belongs_to :restaurant
    belongs_to :user
    has_one_attached :photo
end
