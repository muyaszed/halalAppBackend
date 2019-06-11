require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:restaurants) }
  it {should have_one(:profile)}
  it { should have_many(:bookmarks)}
  it { should have_many(:bookmarked_restaurant)}
  it { should have_many(:check_ins)}
  it { should have_many(:checked_ins)}
  
  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password_digest)}
end
