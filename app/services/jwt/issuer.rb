module Jwt
  class Issuer
    def initialize(user)
      @user = user
    end

    def call
      Token.create!(crypted_token: refresh_token)

      [access_token, refresh_token]
    end

    private

    def access_token
      Jwt::Encoder.new(
        @user,
        Jwt::Secret.access_token,
        Jwt::Expiry.access_expiry
      ).()
    end

    def refresh_token
      @refresh_token ||= begin
        Jwt::Encoder.new(
          @user,
          Jwt::Secret.refresh_token,
          Jwt::Expiry.refresh_expiry
        ).()
      end
    end
  end
end
