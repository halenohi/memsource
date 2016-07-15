require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) do
    FactoryGirl.create(:user)
  end

  let!(:circle) do
    FactoryGirl.create(:circle)
  end

  describe 'associations' do
    it 'should has many memberships' do
      membership = user.memberships.create(circle: circle)
      expect(membership).to be_an_instance_of(Membership)
      expect(user.circles).to eq([circle])
    end
  end
end
