class Api::ChatsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def create
    user = User.find(params[:user_id])
    Pusher['general'].trigger('chat_event', {
      message: params[:message],
      user: user
    })
  end
end
