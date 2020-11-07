class FacebookAuthenticationController < ApplicationController
    skip_before_action :authorize_request, only: [:create]

    def create
        facebook_access_token = params.require(:facebook_access_token)
        from = params.require(:from)
        user, auth_token = AuthenticateFacebookUser.new(facebook_access_token).call
        if from != 'mobile'
            cookies.signed[:jwt] = {value: auth_token, httponly: true}
        end
        json_response(auth_token: auth_token, user: UserSerializer.new(user).as_json)
    end

end