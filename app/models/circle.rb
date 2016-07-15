class Circle < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :members_count, presence: true
end
