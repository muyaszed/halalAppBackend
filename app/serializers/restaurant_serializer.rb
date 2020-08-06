class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :city, :country, :postcode, :category,
  :cuisine, :start, :desc, :cover_uri, :created_at, :end, :latitude, :longitude,
  :location, :web, :updated_at, :contact_number, :soc_med, :family_friendly, :surau, :disabled_accessibility,
  :sub_header
  has_many :bookmarking_user, serializer: UserBookmarkSerializer
  has_many :checking_ins, serializer: UserCheckinSerializer
  has_many :reviews, serializer: UserReviewSerializer


  def updated_at
    self.object.updated_at.to_i
  end

  
end
