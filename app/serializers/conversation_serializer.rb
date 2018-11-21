class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :users, serializer: UserSerializer
end
