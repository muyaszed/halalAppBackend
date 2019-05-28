class Restaurant < ApplicationRecord
    validates :name, :address, :city, :country, :postcode, :category, :cuisine, :start, :desc, presence: true
    belongs_to :user
    has_many :reviews, dependent: :destroy
    has_one_attached :cover
    geocoded_by :location
    after_validation :geocode, :if => :location_changed?

    

    def create_location(object)
        
        address = object[:address] || ""
        city = object[:city] || ""
        postcode = object[:postcode] || ""
        country = object[:country] || ""
        complete_address = address+","+city+","+postcode+","+country
    end

end
