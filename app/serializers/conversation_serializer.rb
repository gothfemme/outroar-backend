class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at
  # has_many :users, serializer: UserSerializer
  # has_many :messages, serializer: MessageSerializer
end
