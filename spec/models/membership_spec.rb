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

  describe '#upadte_circle_members_count' do
    let!(:user2) do
      FactoryGirl.create(:user)
    end

    let!(:user3) do
      FactoryGirl.create(:user)
    end

    let!(:pending_membership) do
      FactoryGirl.create(:membership, circle: circle, user: user, role: :pending)
    end

    let!(:member_membership) do
      FactoryGirl.create(:membership, circle: circle, user: user2, role: :member)
    end

    let!(:owner_membership) do
      FactoryGirl.create(:membership, circle: circle, user: user3, role: :member)
    end

    context 'when update to member role from pending role' do
      it 'should count up circles.members_count column' do
        expect {
          pending_membership.member!
          circle.reload
        }.to change(circle, :members_count).by(1)
      end
    end

    context 'when update to owner role from member role' do
      it 'should not change circles.members_count column' do
        expect {
          member_membership.owner!
          circle.reload
        }.not_to change(circle, :members_count)
      end
    end

    context 'when update to pending role from owner role' do
      it 'should count down circles.members_count column' do
        expect {
          owner_membership.pending!
          circle.reload
        }.to change(circle, :members_count).by(-1)
      end
    end

    context 'when update to pending role from member role' do
      it 'should count down circles.members_count column' do
        expect {
          member_membership.pending!
          circle.reload
        }.to change(circle, :members_count).by(-1)
      end
    end
  end

  describe '#count_down_circle_members_count_if_needed' do
    let!(:user2) do
      FactoryGirl.create(:user)
    end

    let!(:pending_membership) do
      FactoryGirl.create(:membership, user: user2, circle: circle, role: :pending)
    end

    let!(:member_membership) do
      FactoryGirl.create(:membership, user: user2, circle: circle, role: :member)
    end

    let!(:owner_membership) do
      FactoryGirl.create(:membership, user: user2, circle: circle, role: :owner)
    end

    context 'when pending' do
      it 'should not count down circles.members_count column' do
        expect {
          pending_membership.destroy
          circle.reload
        }.not_to change(circle, :members_count)
      end
    end

    context 'when member' do
      it 'should count down circles.members_count column' do
        expect {
          member_membership.destroy
          circle.reload
        }.to change(circle, :members_count).by(-1)
      end
    end

    context 'when owner' do
      it 'should count down circles.members_count column' do
        expect {
          owner_membership.destroy
          circle.reload
        }.to change(circle, :members_count).by(-1)
      end
    end
  end
end
