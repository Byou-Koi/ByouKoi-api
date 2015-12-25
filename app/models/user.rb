class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :chats
  has_many :rooms

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
    isomerisms = User.where.not(sex: self.sex)
    lover = isomerisms.offset( rand(isomerisms.count) ).first
    self.follow(lover)
    lover.follow(self)
    Room.create(user_id: self.id, lover_id: lover.id)
    return lover
  end

  def checked_lover?(target_user)
    Follow.get_follow(self.id, target_user.id).checked
  end

  def check_lover(target_user_id)
    follow = Follow.get_follow(self.id, target_user_id)
    follow.update(checked: true)
  end

  def longest_periods
    anniversary = self.follows.order("created_at").first.created_at
    today = Date.today
    today.day - anniversary.to_date.day
  end

  def last_message_text(lover)
    room = self.rooms.find_by(lover_id: lover.id)
    room.chats.order("created_at desc").first
  end
end
