module Jwt
  class Encoder
    def initialize(user, verify_key, expiry = Jwt::Expiry.access_expiry)
      @user       = user
      @expiry     = expiry
      @verify_key = verify_key
    end

    def call
      JWT.encode(payload, @verify_key)
    end

    private

    def payload
      {
        user_id:  @user.id,
        jti:      SecureRandom.hex,
        iat:      token_issued_at.to_i,
        exp:      token_expiry
      }
    end

    def token_expiry
      (token_issued_at + @expiry).to_i
    end

    def token_issued_at
      Time.now
    end
  end
end
