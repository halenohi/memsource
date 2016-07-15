class Comment < ApplicationRecord
  validates :user_id, presence: true
  validates :circle_id, presence: true
  validates :content, presence: true
end
