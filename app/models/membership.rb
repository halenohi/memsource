class Membership < ApplicationRecord
  validates :user_id, presence: true
  validates :circle_id, presence: true
  validates :role, presence: true

  belongs_to :user
  belongs_to :circle

  # membershipのランク付け
  enum role: [:pending, :member, :owner]

  after_create :count_up_circle_members_count
  after_save :update_circle_members_count, on: :update
  before_destroy :count_down_circle_members_count_if_needed

  def count_up_circle_members_count
  	circle.members_count += 1
  	circle.save!
  end

  def update_circle_members_count
  	if role_was == "pending" && role == "member"
  		circle.members_count += 1
  		circle.save!
  	elsif (role_was == "owner" || role_was == "member") && role == "pending"
  		circle.members_count -= 1
  		circle.save!
  	end
  end

  def count_down_circle_members_count_if_needed
  	if role == "owner" || role == "member"
  		circle.members_count -= 1
  		circle.save!
  	end
  end
end
