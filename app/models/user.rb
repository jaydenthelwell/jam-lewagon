class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :swiper_relationships, foreign_key: :swiper_id, class_name: 'Swipe'
  has_many :swiper, through: :swiper_relationships, source: :swiper

  has_many :swipee_relationships, foreign_key: :swipee_id, class_name: 'Swipe'
  has_many :swipee, through: :swipee_relationships, source: :swipee


  def swipe(user_id)
    swiper_relationships.create(swipee_id: user_id)
  end

  def unswipe(user_id)
    swipee_relationships.find_by(swipee_id: user_id).destroy
  end

  def is_following?(user_id)
    relationship = Swipe.find_by(swiper_id: id, swipee_id: user_id)
    return true if relationship
  end
end
