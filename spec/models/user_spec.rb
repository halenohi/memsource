require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) do
    FactoryGirl.create(:user)
  end

  describe 'associations' do
    it 'should has many memberships' do
      expect(user.memberships.create).to be_an_instance_of(Membership)
    end
  end
end
