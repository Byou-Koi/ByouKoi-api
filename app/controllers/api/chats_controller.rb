class Api::ChatsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    room = Room.find_by(auth_token: params[:room_token])
    @chats = room.chats
  end

  def create
    Chat.create(create_params)
    Pusher[params[:room_token]].trigger('chat_event', {
      message: create_params[:message],
      user: User.find(create_params[:user_id])
    })
  end

  private
  def chat_params
    params.permit(:user_id, :target_user_id)
  end


  def create_params
    room = Room.find_by(auth_token: params[:room_token])
    params.permit(:user_id, :message).merge(room_id: room.id)
  end
end
