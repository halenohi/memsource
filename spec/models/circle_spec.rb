require 'rails_helper'

RSpec.describe Circle, type: :model do
  let!(:user) do
    FactoryGirl.create(:user)
  end

  let!(:circle) do
    FactoryGirl.create(:circle)
  end

  describe 'associations' do
    it 'should has many comments' do
      comment = circle.comments.create({ user_id: user.id, content: 'content'})
      expect(circle.comments).to eq([comment])
    end
  end
end
