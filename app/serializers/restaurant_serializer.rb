class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :city, :country, :postcode, :category, :cuisine, :start, :desc, :cover_uri, :created_at, :end, :latitude, :longitude, :location, :web
  has_many :bookmarking_user
end
