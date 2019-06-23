class AuthorizeApiRequest

    def initialize(headers={})
      
      @headers = headers
    end
  
    def call
      {
        user: user
      }
    end
  
    private
  
    attr_reader :headers
  
    def user
      #include facebook authentication
      if User.find_by_id(decoded_auth_token[:user_id])
        @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
      elsif FacebookAuth.find_by(uid: decoded_auth_token[:fb_id])
        @user ||= FacebookAuth.find_by(uid: decoded_auth_token[:fb_id]) if decoded_auth_token
      else
        raise(
          ExceptionHandler::InvalidToken,
          Message.invalid_token
        )
      end
      
    end
  
    def decoded_auth_token
      
      @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
    end
  
    def http_auth_header
      
      if headers['Authorization'].present?
        return headers['Authorization'].split(' ').last
      end

      raise(ExceptionHandler::MissingToken, Message.missing_token)
    end
end