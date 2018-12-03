class AdminConversationHistorySerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :messages, serializer: MessageSerializer
  attribute :owner do
    object.owner.username
  end
  attribute :is_admin do
    true
  end
  attribute :has_password do
    !!object.password
  end
end
