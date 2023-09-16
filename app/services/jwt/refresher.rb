module Jwt
  class RefresherInvalidToken < V1::ExceptionHandler::AccessDenied; end

  class Refresher
    def initialize(refresh_token:, access_token:)
      @refresh_token = refresh_token
      @access_token = access_token
    end

    def call
      raise Jwt::RefresherInvalidToken unless existing_refresh_token.present?

      new_access_token, new_refresh_token = Jwt::Issuer.new(user).()
      existing_refresh_token.destroy!

      [new_access_token, new_refresh_token]
    end

    private

    def existing_refresh_token
      @existing_refresh_token ||= Token.find_by_crypted_token(@refresh_token)
    end

    def user
      raise(Jwt::RefresherInvalidToken) if verify_refresh_token.blank?

      User.find(verify_refresh_token.fetch(:user_id))
    end

    def verify_refresh_token
      @verify_refresh_token ||= begin
        Jwt::Decoder.new(
          existing_refresh_token.crypted_token,
          Jwt::Secret.refresh_token
        ).()
      end
    end
  end
end
