require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  
  #validation
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:address)}
  it {should validate_presence_of(:city)}
  it {should validate_presence_of(:country)}
  it {should validate_presence_of(:postcode)}
  it {should validate_presence_of(:cuisine)}
  it {should validate_presence_of(:category)}
  it {should validate_presence_of(:start)}
  it {should validate_presence_of(:desc)}
  it {should validate_presence_of(:contactNumber)}
  #association
  it {should belong_to(:user)}
  it {should have_many(:bookmarks)}
  it {should have_many(:bookmarking_user)}
  it { should have_many(:check_ins)}
  it { should have_many(:checking_ins)}

  describe 'create location' do
    let(:restaurant) {create(:restaurant)}
    let(:data) {
      {
      address: "31 jalan bakawali 1",
      postcode: "81100",
      city: "Johor Bahru",
      country: "Malaysia"
      }
    }
    it 'concatenate address, postcode, city and country' do
      
      location = restaurant.create_location(data)
    
      expect(location).to eq(data[:address].concat(",", data[:city], ",", data[:postcode], ",", data[:country]))
    end
  end
end
