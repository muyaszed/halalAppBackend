require 'rails_helper'

RSpec.describe 'reataurant API', type: :request do
    let(:user) { create(:user)}
    let!(:restaurants) { create_list(:restaurant, 10, user_id: user.id)}
    let(:restaurant_id) {restaurants.first.id}
    let(:headers) {valid_headers}

    describe 'GET /restaurants' do
        before {get '/restaurants', params: {}, headers: headers}

        it 'returns restaurant' do
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end

    describe 'POST /restaurants' do
        #valid payloads
        let (:valid_data) { 
                                {
                                    name: 'Tumes Cafe',
                                    location: 'Cheras',
                                    category: 'Johore Food',
                                    desc: 'This is a description',
                                    user_id: user.id
                                }.to_json
                            
                          }
        context 'when the request is valid' do
            
            before { 
                
                post '/restaurants', params: valid_data, headers: headers }

            it 'create new restaurants' do
                expect(json['name']).to eq('Tumes Cafe')
                expect(json['location']).to eq('Cheras')
            end

            it 'returns status code of 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'request is not valid' do
            before { post '/restaurants', params: {name: 'Tumes Cafe', category: 'Johore Food', desc: 'Description'}.to_json, headers: headers }

            it 'returns the code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns failure message' do
                expect(response.body).to match("{\"message\":\"Validation failed: Location can't be blank\"}")
            end
        end
        
    end

    describe 'GET /restaurants/:id' do
        
        before { get "/restaurants/#{restaurant_id}", params: {}, headers: headers}
        
        context 'when the reord exist' do
            it 'return the restaurant' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(restaurant_id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the reccord does not exist' do
            let(:restaurant_id) { 8888 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                
                expect(response.body).to match("{\"message\":\"Couldn't find Restaurant with 'id'=8888\"}")
            end
        end
    end

    describe 'PUT /restaurants/:id' do
        let (:valid_data) { 
                            {
                                name: 'Tumes Cafe',
                                location: 'Cheras',
                                category: 'Johore Food'
    }.to_json
                          }
        context 'when the record exist' do
            before { put "/restaurants/#{restaurant_id}", params: valid_data, headers: headers }
            it 'updates the record' do
                expect(response.body).to be_empty
            end
        
            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end

    end

    describe 'DELETE /restaurants/:id' do
        before { delete "/restaurants/#{restaurant_id}", params: {}, headers: headers }
    
        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
      end
end