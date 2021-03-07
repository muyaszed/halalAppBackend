class UserAppleAuth < ApplicationRecord
  belongs_to :user, optional: true
end
