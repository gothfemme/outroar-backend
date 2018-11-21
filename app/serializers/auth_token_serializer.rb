class AuthTokenSerializer < ActiveModel::Serializer

  attributes :jwt, :current_user

  def jwt
    object.token
  end

  # def payload
  #   object.payload
  # end

  def current_user
  UserSerializer.new(User.find(object.payload[:sub]))
  end
end
