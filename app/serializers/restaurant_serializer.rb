class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :city, :country, :postcode, :category, :cuisine, :start, :desc, :cover_uri, :created_at, :end, :latitude, :longitude, :location, :web, :updated_at
  has_many :bookmarking_user, serializer: UserBookmarkSerializer
  has_many :checking_ins, serializer: UserCheckinSerializer


  def updated_at
    self.object.updated_at.to_i
  end
end
