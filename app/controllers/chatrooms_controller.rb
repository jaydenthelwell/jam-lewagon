class ChatroomsController < ApplicationController
  def index
    @chatrooms = Chatroom.all

    @chatrooms.map do |chatroom|
      chatroom if ![chatroom.match.swipe.swiper, chatroom.match.swipe.swipee].include?(current_user)
    end
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @match = Match.find(@chatroom.match_id)
    @swipe = Swipe.find(@match.swipe_id)
    # @other_user = User.chatroom_user(@match.id)
    if current_user.id == @swipe.swipee_id
      @other_user = User.chatroom_user(@swipe.swiper_id)
    else
      @other_user = User.chatroom_user(@swipe.swipee_id)
    end
    @other_user_profile = @other_user.profile

    if ![@match.swipe.swiper, @match.swipe.swipee].include?(current_user)
      redirect_to root_path, notice: "You are not in the chat"
      return
    end
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end
end
