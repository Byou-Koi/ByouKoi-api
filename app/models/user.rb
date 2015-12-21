class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 4 }, if: -> { new_record? || changes["password"] }
  validates :password, confirmation: true, if: -> { new_record? || changes["password"] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes["password"] }
  validates :name, presence: true
  validates :email, uniqueness: true
  validates :email, presence: true

  before_create :generate_access_token

  mount_uploader :avatar, AvatarUploader

  acts_in_relation role: :self, action: :follow

  def generate_access_token
    begin
      self.auth_token = SecureRandom.hex
    end while self.class.exists?(auth_token: auth_token)
  end

  def meet_your_soul_mate
    lover = User.where.not(sex: self.sex).offset( rand(User.count) ).first
    self.follow(lover)
    lover.follow(self)
    return lover
  end

  def checked_lover?(target_user)
    Follow.find_by(user_id: self.id, target_user_id: target_user.id).checked
  end

  def check_lover(target_user_id)
    follow = Follow.find_by(user_id: self.id, target_user_id: target_user_id)
    follow.update(checked: true)
  end
end
