class ChatroomsController < ApplicationController
  def index
    @chatrooms = Chatroom.all
  end

  def show
    @match = Match.find(params[:id])

    if ![@match.swipe.swiper, @match.swipe.swipee].include?(current_user)
      redirect_to root_path, notice: "You are not in the chat"
      return
    end

    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end
end
