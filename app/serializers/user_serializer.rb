class UserSerializer < ActiveModel::Serializer
    attributes :id, :email
    has_many :restaurants
    has_many :reviews
    has_one :profile
    has_many :bookmarked_restaurant
    has_many :checked_ins

  end
  