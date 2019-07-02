class FacebookAuthenticationController < ApplicationController
    skip_before_action :authorize_request, only: [:create]

    def create
    
        facebook_access_token = params.require(:facebook_access_token)
        user, auth_token = AuthenticateFacebookUser.new(facebook_access_token).call
        # user, auth_token = User.find_or_create_with_facebook_access_token(facebook_access_token)
        json_response(auth_token: auth_token, user: UserSerializer.new(user).as_json)
        

    end

end