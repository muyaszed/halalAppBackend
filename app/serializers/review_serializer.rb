class ReviewSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :restaurant_id, :comment, :created_at, :updated_at, :user_id, :restaurant_name, :photo_uri
  belongs_to :user, serializer: UserShortSerializer
  belongs_to :restaurant

  def restaurant_name
    self.object.restaurant.name
  end
end
