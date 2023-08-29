class Swipe < ApplicationRecord
  belongs_to :swiper, class_name: 'User'
  belongs_to :swipee, class_name: 'User'
end
