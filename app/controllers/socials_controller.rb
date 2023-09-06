class SocialsController < ApplicationController
  def index
    # @user = User.find(params[:user_id])
    @social = Social.new
    # @socials = Social.where(user: @user).order(created_at: :desc)
    @matched_ids = current_user.matched
    @my_socials = current_user.socials.order(created_at: :desc)

    @socials = Social.where(user: @matched_ids).order(created_at: :desc)

    @all_socials = @my_socials + @socials
    # raise
  end

  def new
    @social = Social.new
  end

  def show
    @user = User.find(params[:user_id])
  end

  def create
    @social = Social.new(social_params)
    @social.user = current_user
    @social.save
    if @social.save
      redirect_to socials_path, notice: "Social post created successfully"
    else
      flash.now[:alert] = "There were errors in your submission."
      render :new
    end
  end

  def destroy
    @social = Social.find(params[:id])
      if @social.user == current_user
        @social.destroy
        flash[:notice] = "Successfully deleted"
      else
        flash[:alert] = "You are not authorized to delete this post"
      end
      redirect_to socials_path
  end

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
