class Chatroom < ApplicationRecord
  belongs_to :match
  has_many :messages
end
