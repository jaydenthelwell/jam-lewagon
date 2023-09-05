class SocialsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @social = Social.new
    @socials = Social.where(user: @user)
    # raise
  end

  def show
    @user = User.find(params[:user_id])
  end

  def create
    # @social = current_user.socials.build(social_params)

    @social = Social.new(social_params)
    @social.user = current_user
    @social.save

    # if @social.save
    #   if params[:images]
    #     params[:images].each do |img|
    #       @social.photos.create(image: params[:images][img])
    #     end
    #   end
    #   redirect_to socials_path
    #   flash[:notice] = "Saved ..."
    # else
    #   flash[:alert] = "Something went wrong ..."
    #   redirect_to socials_path
    # end
  end

  # def destroy
  #   if @social.user == current_user
  #     if @social.destroy
  #       flash[:notice] = "post deleted!"
  #     else
  #       flash[:alert] = "Something went wrong ..."
  #     end
  #   else
  #     flash[:notice] = "You don't have permission"
  #   end
  #   redirect_to root_path
  # end

  private

  def social_params
    params.require(:social).permit(:photo)
  end
end

# when I create my social
# be able to add a snippet of a song
# be able to add filters to your posts

# when the other users see my social / i see the others
# be able to switch between social posts - only if youre matched
# be able to send a message to user who posted
