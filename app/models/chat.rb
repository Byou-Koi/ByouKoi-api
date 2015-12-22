class Chat < ActiveRecord::Base
  belongs_to :room
  belongs_to :user

  scope :get_chats, ->(my_follow, target_follow) { where(follow_id: [my_follow.id, target_follow.id]) }
end
