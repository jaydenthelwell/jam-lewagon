class ProfilesController < ApplicationController
  # before_action :authenticate_user!, :only [:edit, :update]
  # before_action :correct_user, :only [:edit, :update]

  def show
    @profile = Profile.find(params[:id])
  end

  def edit
    @profile = Profile.find_by(user_id: current_user.id)
  end

  def update
    @profile = Profile.find_by(user_id: current_user.id)
    if @profile.update(profile_params)
      flash[:notices] = ["Your profile was successfully updated"]
      render 'show'
    else
      flash[:notices] = ["Your profile could not be updated"]
      render 'edit'
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :description)
  end

  # def correct_user
  #   @profile = Profile.find_by(user_id: params[:user_id])
  #   redirect_to(root_path) unless current_user?(@profile)
  # end
end
