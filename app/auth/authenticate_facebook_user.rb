class AuthenticateFacebookUser
    def initialize oauth_token
        @oauth_token = oauth_token
    end

    def call
        begin
            if profile
                data = {
                    name: profile['name'],
                    email: profile['email'],
                    uid: profile['id'],
                    oauth_token: oauth_token,
                    fb_avatar: "https://graph.facebook.com/#{profile['id']}/picture?type=large&access_token=#{@oauth_token}",
                }
                if user = User.find_by(email: profile['email'])
                   if user.facebook_auth
                        user.facebook_auth.update_attributes!(data)
                        [user, JsonWebToken.encode(user_id: user.id)]    
                   else
                        user.create_facebook_auth(data)
                        [user, JsonWebToken.encode(user_id: user.id)]
                   end
                else
                    user = User.new(email: profile['email'])
                    user.save(:validate => false)
                    user.profile.update!(first_name: profile['first_name'], last_name: profile['last_name'])
                    user.create_facebook_auth!(data)
                    [user, JsonWebToken.encode(user_id: user.id)]
                end
            end
                
        rescue Koala::Facebook::AuthenticationError
            raise(ExceptionHandler::FacebookAuthenticationError, Message.invalid_oauth_access_token)
        end
    end

    private
    attr_reader :oauth_token

    def profile 
        
        graph = Koala::Facebook::API.new(oauth_token)
        profile = graph.get_object('me', fields: ['last_name', 'first_name', 'email'])
        
    end


end