class Member < ApplicationRecord
  has_many :friendships, class_name: 'Friendship'
  has_many :friends, through: :friendships, foreign_key: :friend_id
end
