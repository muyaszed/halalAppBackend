class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :comment, :created_at, :updated_at
  belongs_to :user
  belongs_to :restaurant
end
