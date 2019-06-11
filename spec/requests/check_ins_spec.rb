require 'rails_helper'

RSpec.describe 'check in API', type: :request do
    let(:headers) {valid_headers}
    let(:user) { create(:user)}
    let!(:restaurant) { create(:restaurant)}

    describe 'POST restaurants/:restaurant_id/:user_id/checkin_restaurant' do
        before {post "/restaurants/#{restaurant.id}/#{user.id}/checkin_restaurant", headers: headers}
        
        it 'add checkin' do
            
            expect(restaurant.checking_ins.include?(user)).to be_truthy
        end

        it 'returns status code of 201' do
            expect(response).to have_http_status(204)
        end

       
    end

end