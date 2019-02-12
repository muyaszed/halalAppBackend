require 'rails_helper'

RSpec.describe 'review API', type: :request do
    let(:user) { create(:user)}
    let(:comment_owner) { create(:user)}
    let!(:restaurant) { create(:restaurant, user_id: user.id)}
    let!(:reviews) { create_list(:review, 5, user_id: comment_owner.id, restaurant_id: restaurant.id)}
    let(:review_id) { reviews.first.id }
    let(:headers) {valid_headers}
    
    describe 'GET restaurants/:id/reviews' do
        before {get "/restaurants/#{restaurant.id}/reviews", params: {}, headers: headers}

        it 'returns reviews' do
            expect(json).not_to be_empty
            expect(json.size).to eq(5)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end

    end

    describe 'POST /restaurants/:id/reviews' do
        #valid payloads
        let (:valid_data) { 
                                {
                                    comment: 'The food is so delicious',
                                
                                }.to_json
                            
                          }
        
        context 'when the request is valid' do
            
            before { post "/restaurants/#{restaurant.id}/reviews", params: valid_data, headers: headers }

            it 'create new review' do
                
                expect(json['comment']).to eq('The food is so delicious')
            
            end

            it 'returns status code of 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'request is not valid' do
            before { post "/restaurants/#{restaurant.id}/reviews", params: {commnet: ""}.to_json, headers: headers }

            it 'returns the code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns failure message' do
                expect(response.body).to match("{\"message\":\"Validation failed: Comment can't be blank\"}")
            end
        end
        
    end

    describe 'GET /restaurants/:restaurant_id/reviews/:id' do
        
        before { get "/restaurants/#{restaurant.id}/reviews/#{review_id}", params: {}, headers: headers}
        
        context 'when the reord exist' do
            it 'return the review' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(review_id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the reccord does not exist' do
            let(:review_id) { 8888 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                
                expect(response.body).to match(/Couldn't find Review/)
            end
        end
    end

    describe 'PUT /restaurants/:restaurant_id/reviews/:id' do
        let(:valid_attributes) { { comment: 'New comment' }.to_json }
    
        before { put "/restaurants/#{restaurant.id}/reviews/#{review_id}", params: valid_attributes, headers: headers}
    
        context 'when review exists' do
          it 'returns status code 204' do
            expect(response).to have_http_status(204)
          end
    
          it 'updates the review' do
            updated_review = Review.find(review_id)
            expect(updated_review.comment).to match(/New comment/)
          end
        end
    
        context 'when the review does not exist' do
          let(:review_id) { 0 }
    
          it 'returns status code 404' do
            expect(response).to have_http_status(404)
          end
    
          it 'returns a not found message' do
            expect(response.body).to match(/Couldn't find Review/)
          end
        end
      end

      describe 'DELETE /restaurants/:restaurant_id' do
        before { delete "/restaurants/#{restaurant.id}/reviews/#{review_id}", headers: headers }
    
        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
      end
end