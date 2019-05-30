class User < ApplicationRecord
    after_create_commit :build_profile
    has_secure_password
    has_many :restaurants, dependent: :destroy
    has_many :reviews, dependent: :destroy
    has_one :profile, dependent: :destroy
    validates :email, :password_digest, presence: true

    has_many :bookmarks
    has_many :bookmarked_restaurant, through: :bookmarks, source: :restaurant

    def build_profile
        self.create_profile()
    end
end
