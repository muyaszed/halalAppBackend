require 'rails_helper'

RSpec.describe 'FacebookAuthentication', type: :request do
  # Authentication test suite
  describe 'POST /auth/fb_login' do

    $test_users = Koala::Facebook::TestUsers.new(:app_id => 407010653361287, :secret => "97328fb4dd77a2767e6aaa057dccc457")
    $fb_account = $test_users.create(true, "email")
    # create test user
    let!(:user) { create(:user, email: $fb_account['email']) }
    # set headers for authorization
    let(:headers) { valid_headers.except('Authorization') }
    # set test valid and invalid credentials
    let(:valid_credentials) do
      {
        facebook_access_token: $fb_account['access_token']
      }.to_json
    end
    let(:invalid_credentials) do
      {
        facebook_access_token: 'sdfsdfsdfsdfsdfsdf'
      }.to_json
    end

    # set request.headers to our custon headers
    # before { allow(request).to receive(:headers).and_return(headers) }

    # returns auth token when request is valid
    context 'When request is valid' do
      before { post '/auth/fb_login', params: valid_credentials, headers: headers }

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    # returns failure message when request is invalid
    context 'When request is invalid' do
      before { post '/auth/fb_login', params: invalid_credentials, headers: headers }

      it 'returns a failure message' do
        expect(json['message']).to match(/Invalid OAuth access token./)
      end
    end
  end
end