class Review < ApplicationRecord
    validates :comment, presence: true
    belongs_to :restaurant
    belongs_to :user
end
