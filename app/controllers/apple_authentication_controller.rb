class AppleAuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: [:create]

  def create
      apple_user_info = params
      user, auth_token = AuthenticateAppleUser.new(apple_user_info).call
      cookies.signed[:jwt] = {value: auth_token, httponly: true}
      json_response(auth_token: auth_token, user: UserSerializer.new(user).as_json)
  end

end