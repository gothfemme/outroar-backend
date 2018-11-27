class ConversationHistorySerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :messages, serializer: MessageSerializer
end
