class PresenceChannel < ApplicationCable::Channel
  def subscribed
    # byebug
    @jwt_token = params[:token] || raise(CustomErrorClass)
    @current_user = find_verified_user
    # room = params[:room]
    stream_from "presence_channel_#{params[:room]}"
  end

  def kick_user (data)
    if @current_user.id == Conversation.find(params[:room]).owner.id
      ActionCable.server.broadcast("presence_channel_#{params[:room]}", data)
    end
  end

  def delete_channel(data)
      ActionCable.server.broadcast("presence_channel_#{params[:room]}", data )
  end

  def user_join(data)
    ActionCable.server.broadcast("presence_channel_#{params[:room]}", data)
  end

  def initial_presence(data)
    ActionCable.server.broadcast("presence_channel_#{params[:room]}", data)
  end

  def unsubscribed
    ActionCable.server.broadcast("presence_channel_#{params[:room]}", {action:"user_left", user_id: @current_user.id})

  end

  private

  attr_reader :jwt_token

  def find_verified_user
    payload = decode_token
    User.find(payload[0]['sub'])
  end

  def decoding_key
    Knock.token_secret_signature_key.call
  end

  def decode_token
    JWT.decode(@jwt_token.to_s, decoding_key)
  end
end
