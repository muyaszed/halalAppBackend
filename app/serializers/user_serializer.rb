class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email
  has_many :restaurants
  has_many :reviews
  has_one :profile
end
