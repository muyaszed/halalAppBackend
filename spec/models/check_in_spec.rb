require 'rails_helper'

RSpec.describe CheckIn, type: :model do
  it {should belong_to(:user)}
  it {should belong_to(:restaurant)}
end
