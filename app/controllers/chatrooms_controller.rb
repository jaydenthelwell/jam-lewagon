class ChatroomsController < ApplicationController
  def index
    @chatrooms = Chatroom.all

    @socials = []

    # Check if current_user is the swiper
    @chatrooms.each do |chatroom|
      user_is_swiper = false

      socials_hash = {}

      if chatroom.match.swipe.swiper == current_user
        user_is_swiper = true
      end

      if user_is_swiper
        other_user = chatroom.match.swipe.swipee
        # other_user.socials.each do |social|
        #   @socials << other_user[social]
        # end
      else
        other_user = chatroom.match.swipe.swiper
      end
      socials_hash[other_user] = other_user.socials
      @socials.push(socials_hash)
    end

    # raise
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @match = Match.find(@chatroom.match_id)

    if ![@match.swipe.swiper, @match.swipe.swipee].include?(current_user)
      redirect_to root_path, notice: "You are not in the chat"
      return
    end

    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end
end
