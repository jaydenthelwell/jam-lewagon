class Chatroom < ApplicationRecord
  belongs_to :swipe
  has_many :messages
end
