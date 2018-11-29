class Conversation < ApplicationRecord
  has_many :messages
  has_many :favorites
  has_many :users, through: :favorites

  def like_count
    self.favorites.count
  end
end
