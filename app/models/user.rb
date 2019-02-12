class User < ApplicationRecord
    has_secure_password
    has_many :restaurants
    has_many :reviews
    validates :name, :email, :password_digest, presence: true
end
