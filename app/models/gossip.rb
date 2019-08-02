class Gossip < ApplicationRecord
	belongs_to :user
	has_many :join_gotags
  has_many :tags, through: :join_gotags
  has_many :comments
  has_many :likes
end
