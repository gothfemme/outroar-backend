class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :conversation_id
  attribute :user do
    UserSerializer.new(object.user)
  end
  # belongs_to :user, serializer: UserSerializer
end
