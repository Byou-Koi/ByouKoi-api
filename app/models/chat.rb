class Chat < ActiveRecord::Base
  belongs_to :follow
  belongs_to :user
end
