class Restaurant < ApplicationRecord
    validates :name, :location, :category, :cuisine, :start, :desc, presence: true
    belongs_to :user
    has_many :reviews, dependent: :destroy
    geocoded_by :location
    after_validation :geocode, :if => :location_changed?

end
