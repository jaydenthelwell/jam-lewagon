class UsersController < ApplicationController
  before_action :set_user, only: [:swipe, :unswipe]

  def index
    @users = User.where.not(id: current_user.id)
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
    
  def swipe
    if current_user.swipe(@user.id)
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
  end

  def unswipe
    if current_user.unswipe(@user.id)
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { render action: :follow }
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
