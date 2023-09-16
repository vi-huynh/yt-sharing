module Jwt
  class InvalidToken < StandardError; end

  class Decoder
    WARN_EXCEPTIONS = [
      JWT::DecodeError,
      JWT::ExpiredSignature,
      JWT::ImmatureSignature,
      JWT::VerificationError,
      Jwt::InvalidToken
    ]

    def initialize(token, verify_key = Jwt::Secret.access_token, verify: true)
      @token      = token
      @verify     = verify
      @verify_key = verify_key
    end

    def call
      body = JWT.decode(@token, @verify_key, @verify, verify_iat: true)[0]
      raise Jwt::InvalidToken unless body.present?

      body.symbolize_keys
    rescue *WARN_EXCEPTIONS => e
      Rails.logger.warn("[YTSHARING::JWT] Failed to validate JWT: [#{e.class}] #{e}")

      nil
    end
  end
end
