class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: [:authenticate, :create]
    # return auth token once user is authenticated
  def authenticate
    auth_token, user =
      AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token, user: user)
  end

  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token, user: user }
    json_response(response, :created)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end

  def user_params
    params.permit(
      :first_name,
      :last_name,
      :email,
      :password,
    )
  end
end
