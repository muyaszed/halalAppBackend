class Restaurant < ApplicationRecord
    validates :name, :location, :category, :desc, presence: true
    belongs_to :user
    has_many :reviews
end
