class User < ApplicationRecord
    after_create_commit :build_profile
    has_secure_password
    has_many :restaurants, dependent: :destroy
    has_many :reviews, dependent: :destroy
    has_one :profile
    validates :first_name, :last_name, :email, :password_digest, presence: true

    def build_profile
        self.create_profile()
    end
end
