class Membership < ApplicationRecord
  validates :user_id, presence: true
  validates :circle_id, presence: true
  validates :role, presence: true

  belongs_to :user
  belongs_to :circle
end
