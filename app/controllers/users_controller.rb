class UsersController < ApplicationController
  before_action :set_user, only: [:like, :dislike]

  def index
    @users = User.where.not(id: current_user.id)

    @users = @users.reject do |user|
      current_user.swiped?(user.id)
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
  end

  def like
    if current_user.like(@user.id)
      if @user.swiped_and_liked?(current_user.id)
        @swipe = Swipe.find_by(swiper_id: current_user.id, swipee_id: @user.id)
        Match.create(swipe_id: @swipe.id)
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

  private

  def user_params
    params.require(:user).permit(:name, :location, :description, :birth_year, :gender)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
