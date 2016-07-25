class Circle < ApplicationRecord
  validates :name,
  	presence: true,
  	uniqueness: true

  validates :description,
  	presence: true,
  	length: { minimum: 10 }

  validates :members_count, 
  	presence: true

  has_many :memberships

  has_many :members,
    class_name: 'User',
    source: :user,
    through: :memberships

  has_many :comments
end
