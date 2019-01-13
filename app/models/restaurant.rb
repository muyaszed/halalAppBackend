class Restaurant < ApplicationRecord
    validates :name, :location, :category, presence: true
end
