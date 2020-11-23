class UserShortSerializer < ActiveModel::Serializer
  attributes :id, :email, :settings
  has_many :restaurants
  has_one :profile
  has_one :facebook_auth

  def settings
    {
      :facebook_avatar => self.object.settings(:all).facebook_avatar,
    }
  end
end
