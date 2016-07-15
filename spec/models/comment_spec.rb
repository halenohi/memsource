require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) do
    FactoryGirl.create(:user)
  end

  let!(:circle) do
    FactoryGirl.create(:circle)
  end

  describe 'associations' do
    it 'should belongs to user and circle' do
      comment = Comment.create({ user_id: user.id, circle_id: circle.id })
      expect(comment.user).to eq(user)
      expect(comment.circle).to eq(circle)
    end
  end
end
