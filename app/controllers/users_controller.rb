class UsersController < ApplicationController
  before_action :set_user, only: [:like, :dislike]

  def index
    @users = current_user.users_with_same_genres
    # @users = User.where

    @users = @users.reject do |user|
      current_user.i_swipe(user)
    end
    @users
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      flash[:notices] = ["Your profile was successfully updated"]
      redirect_to profile_path(@user.profile)
    else
      flash[:notices] = ["Your profile could not be updated"]
      render 'edit'
    end
  end

  def profile
    # raise
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
  end

  def like
    Swipe.create(swiper_id: current_user.id, swipee_id: params[:id], like: true)

    @swipe = Swipe.find_by(swipee_id: current_user.id, swiper_id: params[:id], like: true)

    if @swipe != nil
      @swipe.accepted!
      @chatroom = Chatroom.create(swipe_id: @swipe.id)
      # raise

      respond_to do |format|
        format.html { redirect_to users_path, notice: @user }
        # format.js
      end
    else
      redirect_to users_path
    end
  end

  def dislike
    if current_user.dislike(User.find(params[:id]))
      swipe = Swipe.find_by(swipee_id: current_user.id, swiper_id: params[:id])
      unless swipe
        swipe = Swipe.create(swiper_id: current_user.id, swipee_id: params[:id])
        swipe.declined!
        swipe.save
      else
        swipe.declined!
        swipe.save
      end
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

  def user_params
    params.require(:user).permit(:name, :date_of_birth, :location, :gender, :on_repeat, :all_time_favorite, :go_to_karaoke, :description, photos: [])
  end

  def set_user
    @user = User.find(params[:id])
  end
end
