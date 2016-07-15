class Membership < ApplicationRecord
  validates :user_id, presence: true
  validates :circle_id, presence: true
  validates :role, presence: true
end
