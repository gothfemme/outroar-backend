class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :conversation_id
end
