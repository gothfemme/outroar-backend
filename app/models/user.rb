class User < ApplicationRecord
  has_secure_password
  has_many :messages
  has_many :favorites
  has_many :conversations, through: :favorites

  def self.from_token_request request
    username = request.params["auth"] && request.params["auth"]["username"]
    # byebug
    self.find_by username: username
  end
end
