class User < ApplicationRecord
  has_secure_password
  before_create :generate_api_key

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 7 }
  
  private
  def generate_api_key
    self.api_key = SecureRandom.hex(24)
  end
end
