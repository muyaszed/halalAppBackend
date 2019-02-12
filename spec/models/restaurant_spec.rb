require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  #validation
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:location)}
  it {should validate_presence_of(:category)}
  #association
  it {should belong_to(:user)}
end
