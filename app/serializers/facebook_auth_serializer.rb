class FacebookAuthSerializer < ActiveModel::Serializer
    attributes :id, :email, :user_id, :uid, :oauth_token
    
    
end