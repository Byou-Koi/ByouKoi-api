class Api::RoomsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def show
    @room = Room.find(params[:id])
  end


end
