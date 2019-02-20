require 'rails_helper'

RSpec.describe 'review API', type: :request do
    let(:user) { create(:user)}
    let(:headers) {valid_headers}
    let!(:profile_id) {user.profile.id}

    describe 'PUT /profile/:id' do
        let(:valid_attributes) { { avatar: "https://robohash.org/sitsequiquia.png?size=300x300&set=set2" }.to_json }
    
        before {put "/profiles/#{profile_id}", params: valid_attributes, headers: headers}
    
        context 'when profile exists' do
          it 'returns status code 204' do
            expect(response).to have_http_status(204)
          end
    
          it 'updates the profile' do
            updated_profile = Profile.find(profile_id)
            expect(updated_profile.avatar).to match("https://robohash.org/sitsequiquia.png?size=300x300&set=set2")
          end
        end
    
        context 'when the profile does not exist' do
          let(:profile_id) { 0 }
    
          it 'returns status code 404' do
            expect(response).to have_http_status(404)
          end
    
          it 'returns a not found message' do
            expect(response.body).to match(/Couldn't find Profile/)
          end
        end
      end
end