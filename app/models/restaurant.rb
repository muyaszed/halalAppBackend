class Restaurant < ApplicationRecord
    validates :name, :location, :category, presence: true
    belongs_to :user
end
