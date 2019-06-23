require 'rails_helper'

RSpec.describe AuthenticateFacebookUser do
    $test_users = Koala::Facebook::TestUsers.new(:app_id => , :secret => "")
    $fb_account = $test_users.create(true, "email")

  after(:all) do
    $test_users.delete($fb_account)
  end

  # Test suite for AuthenticateUser#call
  describe '#call' do
    
    # return token when valid request
    context 'when valid credentials' do
        subject(:valid_auth_obj) { described_class.new($fb_account['access_token']) }

        context 'user already have a normal account' do

            let!(:normal_user) { create(:user, email: $fb_account['email'])}

            describe 'user already login using FB previously' do
                
                let!(:user_with_prev_fb_login) {normal_user.create_facebook_auth!(email: normal_user['email']).user}
                
                it 'returns user profile' do     
                    @user, @token = valid_auth_obj.call              
                    expect(@user).to eq(user_with_prev_fb_login)
                    
                end
                it 'return acces token' do     
                    @user, @token = valid_auth_obj.call               
                    expect(@token).not_to be_nil
                end
            end
            
            describe 'user have not login using FB previously' do
                
                it 'merge account ' do    
                    @user, @token = valid_auth_obj.call               
                    expect(@user.facebook_auth).not_to be_nil
                end
                it 'return user profile' do   
                    @user, @token = valid_auth_obj.call                
                    expect(@user).to eq(normal_user)
                end
                it 'return token' do   
                    @user, @token = valid_auth_obj.call                 
                    expect(@token).not_to be_nil
                end
            end
        end

        context 'user do not have a normal account' do
            describe 'user already login using FB previously' do
                it 'return token' do
                    @user, @token = valid_auth_obj.call
                    fb_user = FacebookAuth.create(email: $fb_account['email'])
                    expect(@token).not_to be_nil
                end
                it 'return fb_user' do
                    @user, @token = valid_auth_obj.call
                    fb_user = FacebookAuth.create(email: $fb_account['email'])
                    expect(@user['email']).to eq(fb_user['email'])
                end
                
            end
            describe 'user have not login using FB previously' do
                it 'return token' do
                    @user, @token = valid_auth_obj.call
                     expect(@token).not_to be_nil
                end
                it 'return fb_user' do
                    @user, @token = valid_auth_obj.call
                    expect(@user).not_to be_nil
                end
            end
        end
    end

    # raise Authentication Error when invalid request
    context 'when invalid credentials' do
        subject(:invalid_auth_obj) { described_class.new('foo') }
      it 'raises a facebook authentication error' do
        expect { invalid_auth_obj.call }
          .to raise_error(
            ExceptionHandler::FacebookAuthenticationError,
            /Invalid OAuth access token./
          )
      end
    end
  end
end