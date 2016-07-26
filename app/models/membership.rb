class Membership < ApplicationRecord
  validates :user_id, presence: true
  validates :circle_id, presence: true
  validates :role, presence: true

  belongs_to :user
  belongs_to :circle, counter_cache: :members_count

  enum role: [:pending, :member, :owner]
end
