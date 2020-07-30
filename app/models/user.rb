class User < ApplicationRecord
    after_create_commit :build_profile
    has_secure_password
    has_many :restaurants, dependent: :destroy
    has_many :reviews, dependent: :destroy
    has_one :profile, dependent: :destroy
    has_one :facebook_auth, dependent: :destroy
    validates :email, :password_digest, presence: true, uniqueness: true

    has_many :bookmarks
    has_many :bookmarked_restaurant, through: :bookmarks, source: :restaurant

    has_many :check_ins
    has_many :checked_ins, through: :check_ins, source: :restaurant

    def build_profile
        self.create_profile()
    end
end
