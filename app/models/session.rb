class Session < ApplicationRecord
  attr_reader :raw_token

  belongs_to :user

  before_create :generate_token!

  def token
    @token ||= BCrypt::Password.new(token_digest)
  end

  def token=(new_token)
    @token = BCrypt::Password.create(new_token)
    self.token_digest = @token
  end

  def generate_token!
    @raw_token = SecureRandom.hex
    self.token = @raw_token
  end
end
