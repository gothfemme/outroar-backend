class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at
  attribute :owner do
    object.owner.username
  end
  # has_many :users, serializer: UserSerializer
  # has_many :messages, serializer: MessageSerializer
end
