class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :favorite_channels, :color

  def favorite_channels
    object.conversations.pluck(:id)
  end
end
