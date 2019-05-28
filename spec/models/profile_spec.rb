require 'rails_helper'

RSpec.describe Profile, type: :model do
  it {should belong_to(:user)}

  describe 'Avatar Attachement' do
    let(:profile) {create :profile, :with_avatar}

    it 'is valid' do
      expect(profile.avatar).to be_attached
    end
  end
  
end
