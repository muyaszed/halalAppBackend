require 'rails_helper'

RSpec.describe 'bookmark API', type: :request do
    let(:headers) {valid_headers}
    let(:user) { create(:user)}
    let!(:restaurant) { create(:restaurant)}

    describe 'POST restaurants/:restaurant_id/:user_id/bookmark_restaurant' do
        before {post "/restaurants/#{restaurant.id}/#{user.id}/bookmark_restaurant", headers: headers}
        
        it 'add bookmark' do
            
            expect(restaurant.bookmarking_user.include?(user)).to be_truthy
        end

        it 'returns status code of 201' do
            expect(response).to have_http_status(204)
        end

       
    end

    describe 'POST restaurants/:restaurant_id/:user_id/unbookmark_restaurant' do
        before {post "/restaurants/#{restaurant.id}/#{user.id}/unbookmark_restaurant", headers: headers}
        
        it 'revove bookmark' do
            
            expect(restaurant.bookmarking_user.include?(user)).to be_falsey
        end

        it 'returns status code of 201' do
            expect(response).to have_http_status(204)
        end
    end
end