class Follow < ActiveRecord::Base
  acts_in_relation role: :action, self: :user

  scope :get_follow, ->(user_id, target_id) { find_by(user_id: user_id, target_user_id: target_id) }

end
