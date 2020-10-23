class ChatsController < ApplicationController

  def create
    if UserRoom.where(user_id: current_user.id, room_id: params[:chat][:room_id]).present?
      @chat = Chat.create(params.require(:chat).permit(:user_id, :message, :room_id).merge(user_id: current_user.id))
      @room = Room.find_by(id: params[:chat][:room_id])
      @chats = @room.chats
    else
      flash[:alert] = "メッセージに失敗しました。"
    end
  end

  def show
    @room = Room.find_by(id: params[:room_id])
    @user = User.find_by(id: params[:user_id])
    if UserRoom.where(user_id: current_user.id, room_id: @room.id).present?
      @chats = @room.chats
      @chat = Chat.new
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
