class RoomsController < ApplicationController
  def create
    @room = Room.create
    @userRoom1 = UserRoom.create(room_id: @room.id, user_id: current_user.id)
    @userRoom2 = UserRoom.create(user_id: params[:room][:userRoom][:user_id], room_id: @room.id)
    redirect_to chat_path(@room, user_id: params[:room][:userRoom][:user_id])
  end

  def room_params
    params.require(:userRoom2).permit(:room_id, :user_id)
  end
end
