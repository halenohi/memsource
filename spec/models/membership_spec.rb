require 'rails_helper'

RSpec.describe Membership, type: :model do
  let!(:user) do
    FactoryGirl.create(:user)
  end

  let!(:circle) do
    FactoryGirl.create(:circle)
  end

  describe 'associations' do
    it 'should belongs to user and circle' do
      membership = Membership.create({ user_id: user.id, circle_id: circle.id })
      expect(membership.user).to eq(user)
      expect(membership.circle).to eq(circle)
    end
  end
end
