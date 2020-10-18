class FacebookAuthenticationController < ApplicationController
    skip_before_action :authorize_request, only: [:create]

    def create
        facebook_access_token = params.require(:facebook_access_token)
        user, auth_token = AuthenticateFacebookUser.new(facebook_access_token).call
        cookies.signed[:jwt] = {value: auth_token, httponly: true}
        json_response(user: UserSerializer.new(user).as_json)
    end

end