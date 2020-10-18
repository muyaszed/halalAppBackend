class ApplicationController < ActionController::API
    include ::ActionController::Cookies
    include Response
    include ExceptionHandler

    before_action :authorize_request
    attr_reader :current_user

    private

    def authorize_request
        jwt_info = cookies.signed[:jwt]
        @current_user = (AuthorizeApiRequest.new(request.headers, jwt_info).call)[:user]
    end
end
