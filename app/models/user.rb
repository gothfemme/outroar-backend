class User < ApplicationRecord
  has_secure_password
  has_many :messages
  has_many :favorites
  has_many :created_conversations, class_name: :Conversation, foreign_key: "user_id"
  has_many :conversations, through: :favorites
  validates :username, presence: true, uniqueness: true, length: {in: 1..20}, format: {with: /\A[a-zA-Z0-9]+\z/}
  validates :password, presence: true, confirmation: true, length: {in: 6..20}, on: :create

  def self.from_token_request request
    username = request.params["auth"] && request.params["auth"]["username"]
    # byebug
    self.find_by username: username
  end
end
