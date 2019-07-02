module V1  
  class UsersController < ApplicationController
    skip_before_action :authorize_request, only: :create
      # POST /signup
    # return authenticated token upon signup
    # def create
    #   user = User.create!(user_params)
    #   auth_token = AuthenticateUser.new(user.email, user.password).call
    #   response = { message: Message.account_created, auth_token: auth_token, user: user }
    #   json_response(response, :created)
    # end

    def show
      @user = User.find(params[:id])
      json_response(@user)
    end

    def update
      
      @user = User.find(params[:id])
      @user.update(password_digest: params[:password])
      head :no_content
    end

    private

    def user_params
      params.permit(
        :email,
        :password,
      )
    end
  end
end
