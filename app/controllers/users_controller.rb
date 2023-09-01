class UsersController < ApplicationController
  before_action :set_user, only: [:like, :dislike]

  def index
    @users = current_user.users_with_same_genres

    @users = @users.reject do |user|
      current_user.swiped?(user.id)
    end
  end

  def show
    @user = User.find(params[:id])
  end

  # def new
  #   @user = User.new
  # end

  # def create
  #   @user = User.new(user_params)
  #   @user.save
  # end

  def like
    if current_user.like(@user.id)
      if @user.swiped_and_liked?(current_user.id)
        @swipe = Swipe.find_by(swiper_id: current_user.id, swipee_id: @user.id)
        @match = Match.create(swipe_id: @swipe.id)
        Chatroom.create(match_id: @match.id)
      end

      respond_to do |format|
        format.html { redirect_to users_path }
        # format.js
      end
    end
  end

  def dislike
    if current_user.dislike(@user.id)
      respond_to do |format|
        format.html { redirect_to users_path }
        # format.js { render action: :swipe }
      end
    end
  end

  # def pair
  #   @pair = []
  #   @users = User.all
  #   @users.each do |user|
  #       user.genre ==

  #     @pair << user unless @pair.user.include?(user) # make it to only allow two users inside
  #     # for every attribute of the user that matches with another user we add some points and store it in the above variable
  #   end
  # end

  # def users_with_similar_genres
  #   @ordered_list = []
  #   # @score = 0
  #   @users = User.all
  #   # index = 1
  #   # cu_genres = current_user.top_genres
  #   # nu_genres = user.find(index += 1).top_genres
  #   @users.each_with_index do |user, index|
  #     if current_user.top_genres == user.find(index += 1).top_genres
  #       # @score = 5 # Initial score  matching genre
  #       @ordered_list <<  user
  #     end
  #   end
  # end

  # we rank all the other users based on their points towards the current user
  # we show all the other users based on the above ranking

  private

  # def user_params
  #   params.require(:user).permit(:name, :date_of_birth, :location, :gender, :on_repeat, :all_time_favorite, :go_to_karaoke, :description, :photo)
  # end

  def set_user
    @user = User.find(params[:id])
  end
end
