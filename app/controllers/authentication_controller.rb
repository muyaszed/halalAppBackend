class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: [:authenticate, :create]
    # return auth token once user is authenticated
  def authenticate
    from = params[:from]
    auth_token, user =
      AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    if from != 'mobile'
      cookies.signed[:jwt] = {value: auth_token, httponly: true, secure: true, same_site: 'None'}
    end
    json_response(auth_token: auth_token, user: UserSerializer.new(user).as_json)
  end

  def create
    from = params[:from]
    user = User.new(user_params)
    if user.save
      auth_token, user = AuthenticateUser.new(user.email, user.password).call
      if(params[:admin]) 
        user.update(admin: true);
      end
      if from != 'mobile'
        cookies.signed[:jwt] = {value: auth_token, httponly: true, secure: true, same_site: 'None'}
      end
      response = { message: Message.account_created, auth_token: auth_token, user: UserSerializer.new(user).as_json }
      json_response(response, :created)
    else
      existing_user = User.find_by(email: auth_params[:email])
      if existing_user && existing_user.facebook_auth && !existing_user.try(:authenticate, auth_params[:password])
        existing_user.update(password: auth_params[:password])
        auth_token, user = AuthenticateUser.new(existing_user.email, existing_user.password).call
        if from != 'mobile'
          cookies.signed[:jwt] = {value: auth_token, httponly: true, secure: true, same_site: 'None'}
        end
        response = { message: Message.account_created, auth_token: auth_token, user: UserSerializer.new(user).as_json }
        json_response(response, :created)
      elsif existing_user.try(:authenticate, auth_params[:password])
        raise(ExceptionHandler::AuthenticationError, Message.user_already_exist)
      end
    end
  end

  def destroy
    cookies.delete(:jwt);
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
      :admin,
    )
  end
end
