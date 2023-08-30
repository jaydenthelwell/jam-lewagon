class ChatroomsController < ApplicationController
  def index
    @chatrooms = Chatroom.all
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end


  def create
    @chatroom = Chatroom.new(chatroom_params)
    if @chatroom.save
      redirect_to root_path, notice: "chatrooms was successfully created."
    else
      render :chatrooms, status: :unprocessable_entity
    end
  end

  private

  def matches_params
    params.require(:chatroom).permit(:match_id)
  end
end
