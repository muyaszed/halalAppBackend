class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :comment, :created_at, :updated_at, :user_id
  belongs_to :user, serializer: UserShortSerializer
  belongs_to :restaurant
end
