class UsersController < ApplicationController
  before_action :set_user, only: [:swipe, :unswipe]

  def index
    @users = User.where.not(id: current_user.id)
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

  def set_user
    @user = User.find(params[:id])
  end
end
