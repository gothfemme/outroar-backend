class Conversation < ApplicationRecord
  has_many :messages
  has_many :favorites
  belongs_to :owner, class_name: :User, foreign_key: "user_id"
  has_many :users, through: :favorites

  def like_count
    self.favorites.count
  end
end
