class SignalChannel < ApplicationCable::Channel
  def subscribed
    # byebug
    @jwt_token = params[:token] || raise(CustomErrorClass)
    @current_user = find_verified_user
    stream_from "signal_channel_user_#{@current_user.id}"
  end

  def send_signal(data)
    ActionCable.server.broadcast("signal_channel_user_#{data["to"]}", data["payload"])
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
