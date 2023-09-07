class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :swiper_relationships, foreign_key: :swiper_id, class_name: 'Swipe', dependent: :destroy
  has_many :swiper, through: :swiper_relationships, source: :swiper

  has_many :swipee_relationships, foreign_key: :swipee_id, class_name: 'Swipe', dependent: :destroy
  has_many :swipee, through: :swipee_relationships, source: :swipee

  has_many :messages, dependent: :destroy

  has_many :socials, dependent: :destroy

  has_many :top_genres, dependent: :destroy
  has_many :top_tracks, dependent: :destroy
  has_one :profile, dependent: :destroy

  # For cloudinary to work
  has_many_attached :photos

  def dislike(user_id)
    swiper_relationships.create(swipee_id: user_id, like: false)
  end

  def matched
    matched_ids = (self.matches.pluck(:swiper_id) + self.matches.pluck(:swipee_id)).uniq.filter { |id| id != self.id }
  end

  def matches
    swipes = Swipe.where(swiper_id: self.id).or(Swipe.where(swipee_id: self.id)).and(Swipe.where(status: "accepted"))
  end
  # def unswipe(user_id)
  #   swipee_relationships.find_by(swipee_id: user_id).destroy
  # end

  def swiped?(user)
    relationship = Swipe.find_by(swiper_id: user, swipee_id: self.id)
    return true if relationship
  end

  def i_swipe(user)
    relationship = Swipe.find_by(swiper_id: self.id, swipee_id: user.id)
    return true if relationship
  end

  def swiped_and_liked?(user_id)
    relationship = Swipe.find_by(swiper_id: id, swipee_id: user_id, like: true)
    return true if relationship
  end

  def swiped_and_disliked?(user_id)
    relationship = Swipe.find_by(swiper_id: id, swipee_id: user_id, like: false)
    return true if relationship
  end

  def users_with_same_genres
    all_users = User.where.not(id: self.id)

    nr_same_genres = all_users.sort_by do |user|
      nr_same_genres = (user.top_genres.pluck(:genre) & self.top_genres.pluck(:genre)).count
      -nr_same_genres
    end
  end

  def self.chatroom_user(match_id)
    User.find(match_id)
  end
end
