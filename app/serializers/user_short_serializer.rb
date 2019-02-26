class UserShortSerializer < ActiveModel::Serializer
  attributes :id, :email
  has_many :restaurants
  has_one :profile
end
