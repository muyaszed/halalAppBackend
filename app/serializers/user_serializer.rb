class UserSerializer < ActiveModel::Serializer
    attributes :id, :email, :checkinlist
    has_many :restaurants
    has_many :reviews
    has_one :profile
    has_many :bookmarked_restaurant
    

    def checkinlist
      arr = []
      self.object.check_ins.map do |rest|
        
        arr <<  {
                  checkin: rest,
                  detail: Restaurant.find(rest.restaurant_id),
                  time: rest.created_at.localtime.strftime("%d, %b %Y(%H:%M%P)")
                }
      end

      arr
    end

  end
  