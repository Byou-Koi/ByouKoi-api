class Room < ActiveRecord::Base
  has_many :chats
  before_create :generate_token

  def generate_token
    begin
      self.auth_token = SecureRandom.hex
    end while self.class.exists?(auth_token: auth_token)
  end

  def self.get_room_token(user_id, lover_id)
    if Room.find_by(user_id: user_id, lover_id: lover_id)
      return Room.find_by(user_id: user_id, lover_id: lover_id).auth_token
    else
      return Room.find_by(user_id: lover_id, lover_id: user_id).auth_token
    end
  end
end
