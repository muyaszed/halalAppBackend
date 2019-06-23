class User < ApplicationRecord
    after_create_commit :build_profile
    has_secure_password
    has_many :restaurants, dependent: :destroy
    has_many :reviews, dependent: :destroy
    has_one :profile, dependent: :destroy
    has_one :facebook_auth, dependent: :destroy
    validates :email, :password_digest, presence: true

    has_many :bookmarks
    has_many :bookmarked_restaurant, through: :bookmarks, source: :restaurant

    has_many :check_ins
    has_many :checked_ins, through: :check_ins, source: :restaurant

    def build_profile
        self.create_profile()
    end

    # def self.find_or_create_with_facebook_access_token oauth_access_token
    #     graph = Koala::Facebook::API.new(oauth_access_token)
    #     profile = graph.get_object('me', fields: ['name', 'email'])

    #     data = {
    #         name: profile['name'],
    #         email: profile['email'],
    #         uid: profile['id'],
    #         oauth_token: oauth_access_token,
    #         picture_url: "https://graph.facebook.com/#{profile['id']}/picture?type=large",
    #         }

    #     if user = User.find_by(email: profile['email'])
    #         if !user.facebook_auth.nil?
    #             #update
    #             [user.facebook_auth.update_attribute(data), JsonWebToken.encode(user_id: user.id)]
    #         else
    #             #merge
    #             [user.create_facebook_auth!(data), JsonWebToken.encode(user_id: user.id)]
    #         end
    #     else
    #         if fb_auth = FacebookAuth.find_by(email: profile['email'])
    #             fb_auth.update_attribute(data)
    #             [fb_auth, JsonWebToken.encode(fb_id: fb_auth.uid)]
    #         else
    #             #new
    #             fb_auth = FacebookAuth.create!(data)
    #             [fb_auth, JsonWebToken.encode(fb_id: fb_auth.uid)]
    #         end
    #     end
    # end
end
