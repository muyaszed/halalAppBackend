class AuthorizeApiRequest

    def initialize(headers={}, jwt_info)
      
      @headers = headers
      @jwt_info = jwt_info
    end
  
    def call
      {
        user: user
      }
    end
  
    private
  
    attr_reader :headers
    attr_reader :jwt_info
  
    def user
      @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
  
    rescue ActiveRecord::RecordNotFound => e
      raise(
        ExceptionHandler::InvalidToken,
        ("#{Message.invalid_token} #{e.message}")
      )
      
    end
  
    def decoded_auth_token
      jwt = jwt_info ? jwt_info : http_auth_header
      @decoded_auth_token ||= JsonWebToken.decode(jwt)
    end
  
    def http_auth_header
      
      if headers['Authorization'].present?
        return headers['Authorization'].split(' ').last
      end

      raise(ExceptionHandler::MissingToken, Message.missing_token)
    end
end