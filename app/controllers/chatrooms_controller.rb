class ChatroomsController < ApplicationController
  def index
    @chatrooms_data = Chatroom.all
    @social = Social.new
    @socials = []

    # Check if current_user is the swiper

    @chatrooms = []

    @chatrooms_data.each do |chatroom|
      user_is_swiper = false

      socials_hash = {}

      if chatroom.swipe.swiper == current_user
        user_is_swiper = true
      end

      if user_is_swiper
        other_user = chatroom.swipe.swipee
        # other_user.socials.each do |social|
        #   @socials << other_user[social]
        # end
      else
        other_user = chatroom.swipe.swiper
      end

      socials_hash[other_user] = other_user.socials
      @socials.push(socials_hash)


      @chatrooms = @chatrooms_data.select do |chatroom|
        [chatroom.swipe.swiper, chatroom.swipe.swipee].include?(current_user)
      end
    end

    @chatrooms = @chatrooms.sort_by { |chatroom| chatroom.updated_at }.reverse
    # raise
  end

  def show
    @chatroom = Chatroom.find(params[:id])

    @swipe = Swipe.find(@chatroom.swipe_id)

    if @swipe.swiper == current_user
      @other_user = @swipe.swipee
      # @other_user_profile = @other_user.profile
    else
      @other_user = @swipe.swiper
    end

    # raise

    if ![@swipe.swiper, @swipe.swipee].include?(current_user)
      redirect_to root_path, notice: "You are not in the chat"
      return
    end

    # @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

  def user_chatrooms
    @chatrooms_ids = Chatroom.all.map do |chatroom|
      chatroom.id if chatroom.swipe.swiper == current_user || chatroom.swipe.swipee == current_user
    end
    render json: { chatrooms: @chatrooms_ids, user_id: current_user.id }
  end

end
