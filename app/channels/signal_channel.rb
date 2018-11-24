class SignalChannel < ApplicationCable::Channel
  def subscribed
    # byebug
    @jwt_token = params[:token] || raise(CustomErrorClass)
    @current_user = find_verified_user
    # room = params[:room]
    stream_from "signal_channel_#{params[:room]}_user_#{@current_user.id}"
  end

  def send_signal(data)
    ActionCable.server.broadcast("signal_channel_#{params[:room]}_user_#{data["to"]}", data.merge({from: @current_user.id})) unless data["to"] == @current_user.id
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
