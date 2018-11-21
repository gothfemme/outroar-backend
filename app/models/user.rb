class User < ApplicationRecord
  has_secure_password
  has_many :messages
  has_many :memberships
  has_many :conversations, through: :memberships

  def self.from_token_request request
    username = request.params["auth"] && request.params["auth"]["username"]
    # byebug
    self.find_by username: username
  end
end
