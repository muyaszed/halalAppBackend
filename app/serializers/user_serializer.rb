class UserSerializer < ActiveModel::Serializer
    attributes :id, :email, :checkinlist, :password_digest, :settings, :admin
    has_many :restaurants
    has_many :reviews
    has_one :profile
    has_many :bookmarked_restaurant
    has_one :facebook_auth
    

    def checkinlist
      arr = []
      self.object.check_ins.map do |rest|
        
        arr <<  {
                  checkin: rest,
                  detail: Restaurant.find(rest.restaurant_id),
                  date: rest.created_at.localtime.strftime("%d, %b %Y(%H:%M%P)"),
                  time: rest.created_at.localtime.to_i
                }
      end

      arr
    end

    def settings
      {
        :facebook_avatar => self.object.settings(:all).facebook_avatar,
        :distance_unit => self.object.settings(:all).distance_unit
      }
    end

  end
  