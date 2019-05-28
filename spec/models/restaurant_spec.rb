require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  #validation
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:address)}
  it {should validate_presence_of(:city)}
  it {should validate_presence_of(:postcode)}
  it {should validate_presence_of(:country)}
  it {should validate_presence_of(:category)}
  it {should validate_presence_of(:cuisine)}
  it {should validate_presence_of(:desc)}
  it {should validate_presence_of(:start)}

  #association
  it {should belong_to(:user)}
  it {should have_many(:reviews)}

  describe 'Cover Attachment' do
    let(:restaurant) { create :restaurant, :with_cover}
    it 'is valid' do 
      expect(restaurant.cover).to be_attached
    end
  end

  #method
  describe 'create_location' do
    let(:restaurant) { create(:restaurant)}
    let(:complete) {restaurant[:address] + "," + restaurant[:city] + "," + restaurant[:postcode] + "," + restaurant[:country]}
    it 'should concate other attribute to make a single string' do
      location = restaurant.create_location(restaurant)
      # location = "This is a string"
      
      expect(location).to eq(complete)
      # expect(location).to eq("This is a string la")
    end
  end
  
end
