class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]
  # skip_before_action :authenticate_user!, only: [:show]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @currentUserUserRoom = UserRoom.where(user_id: current_user.id)
    @userUserRoom = UserRoom.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserUserRoom.each do |cu|
        @userUserRoom.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @userRoom = UserRoom.new
      end
    end
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
