require 'rails_helper'

RSpec.describe Review, type: :model do
  #validation
  it {should validate_presence_of(:comment)}
  #associations
  it {should belong_to(:user)}
  it {should belong_to(:restaurant)}

end
