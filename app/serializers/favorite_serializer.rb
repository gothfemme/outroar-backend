class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :channel_id
end
