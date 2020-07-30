class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: [:authenticate, :create]
    # return auth token once user is authenticated
  def authenticate
    auth_token, user =
      AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token, user: UserSerializer.new(user).as_json)
  end

  def create
    user = User.new(user_params)
    if user.save
      auth_token, user = AuthenticateUser.new(user.email, user.password).call
      response = { message: Message.account_created, auth_token: auth_token, user: UserSerializer.new(user).as_json }
      json_response(response, :created)
    else
      existing_user = User.find_by(email: auth_params[:email])
      if existing_user && existing_user.facebook_auth && !existing_user.try(:authenticate, auth_params[:password])
        existing_user.update(password: auth_params[:password])
        auth_token, user = AuthenticateUser.new(existing_user.email, existing_user.password).call
        response = { message: Message.account_created, auth_token: auth_token, user: UserSerializer.new(user).as_json }
        json_response(response, :created)
      elsif existing_user.try(:authenticate, auth_params[:password])
        raise(ExceptionHandler::AuthenticationError, Message.user_already_exist)
      end
    end
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
