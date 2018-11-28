class User < ApplicationRecord
  has_secure_password
  has_many :messages
  has_many :favorites
  has_many :conversations, through: :favorites
  validates :username, presence: true, uniqueness: true, length: {in: 1..20}
  validates :password, presence: true, confirmation: true, length: {in: 6..20}, on: :create

  def self.from_token_request request
    username = request.params["auth"] && request.params["auth"]["username"]
    # byebug
    self.find_by username: username
  end
end
