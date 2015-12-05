class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 4 }, if: -> { new_record? || changes["password"] }
  validates :password, confirmation: true, if: -> { new_record? || changes["password"] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes["password"] }
  validates :name, presence: true
  validates :email, uniqueness: true
  validates :email, presence: true

  before_create :generate_access_token

  def generate_access_token
      begin
        self.auth_token = SecureRandom.hex
      end while self.class.exists?(auth_token: auth_token)
    end
end
