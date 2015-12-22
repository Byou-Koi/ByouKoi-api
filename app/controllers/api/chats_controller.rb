class Api::ChatsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    follow = Follow.get_follow(chat_params[:user_id], chat_params[:target_user_id])
    @chats = follow.chats
  end

  def create
    Chat.create(create_params)
    Pusher['general'].trigger('chat_event', {
      message: create_params[:message],
      user: User.find(create_params[:user_id])
    })
  end

  private
  def chat_params
    params.permit(:user_id, :target_user_id)
  end


  def create_params
    follow = Follow.get_follow(chat_params[:user_id], chat_params[:target_user_id])
    params.permit(:user_id, :message).merge(follow_id: follow.id)
  end
end
