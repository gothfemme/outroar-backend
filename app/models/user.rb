class User < ApplicationRecord
  has_secure_password

  def self.from_token_request request
    username = request.params["auth"] && request.params["auth"]["username"]
    # byebug
    self.find_by username: username
  end
end
