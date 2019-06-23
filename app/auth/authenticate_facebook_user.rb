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
                    fb_avatar: "https://graph.facebook.com/#{profile['id']}/picture?type=large",
                }
                # byebug
                if user = User.find_by(email: profile['email'])
                    # byebug
                    if !user.facebook_auth.nil?
                        
                        #update
                        user.facebook_auth.update_attributes!(data)
                        # byebug
                        [user, JsonWebToken.encode(user_id: user.id)]
                    else
                        #merge
                    
                        user.create_facebook_auth!(data)
                        [user, JsonWebToken.encode(user_id: user.id)]
                    end
                else
                    if fb_auth = FacebookAuth.find_by(email: profile['email'])
                        fb_auth = fb_auth.update_attributes!(data)
                        byebug
                        [fb_auth, JsonWebToken.encode(fb_id: fb_auth.uid)]
                    else
                        #new
                        fb_auth = FacebookAuth.create!(data)
                        [fb_auth, JsonWebToken.encode(fb_id: fb_auth.uid)]
                    end
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
        profile = graph.get_object('me', fields: ['name', 'email'])
        
    end


end