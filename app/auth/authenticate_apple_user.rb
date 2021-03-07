class AuthenticateAppleUser
  def initialize user_info
      @apple_user_info = user_info
  end

  def call
      begin
          if user_authenticate?

              data = {
                  name: @apple_user_info[:fullName][:givenName] + ' ' + @apple_user_info[:fullName][:familyName],
                  email: user_authenticate?[:email],
                  uid: @apple_user_info[:user],
                  auth_code: @apple_user_info[:authorizationCode]
              }

              if user = User.find_by(email: data[:email])
                 if user.user_apple_auth
                      user.user_apple_auth.update_attributes!(data)
                      [user, JsonWebToken.encode(user_id: user.id)]    
                 else
                      user.create_user_apple_auth(data)
                      [user, JsonWebToken.encode(user_id: user.id)]
                 end
              else
                  user = User.new(email: data[:email])
                  user.save(:validate => false)
                  user.create_user_apple_auth!(data)
                  [user, JsonWebToken.encode(user_id: user.id)]
              end
          end
              
    rescue AppleAuth::Conditions::JWTValidationError, OAuth2::Error, JWT::ExpiredSignature => e
        raise(ExceptionHandler::AppleAuthenticationError, e.message)
      end
  end

  private
  attr_reader :apple_user_info

  def user_authenticate? 
      token = @apple_user_info[:identityToken]
      user_id = @apple_user_info[:user]
      user = AppleAuth::UserIdentity.new(user_id, token).validate!      
  end


end