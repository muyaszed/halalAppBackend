require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:new_user) { build(:user) }
  let(:user) { create(:user)}
  let(:user_id) {user.id}
  let(:headers) { valid_headers.except('Authorization') }
  let(:headers_with_token) {valid_headers}
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: new_user.password)
  end

  # User signup test suite
  describe 'POST /signup' do
    context 'when valid request' do
      before { post '/signup', params: valid_attributes.to_json, headers: headers }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Password can't be blank, First name can't be blank, Last name can't be blank, Email can't be blank, Password digest can't be blank/)
      end
    end
  end

  describe 'GET /users/:id' do
    before { get "/users/#{user_id}", params: {}, headers: headers_with_token}
        
        context 'when the record exist' do
            it 'return the user' do
                
                expect(json).not_to be_empty
                expect(json['id']).to eq(user_id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the reccord does not exist' do
            let(:user_id) { 8888 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                
                expect(response.body).to match("{\"message\":\"Couldn't find User with 'id'=8888\"}")
            end
        end
  end
end