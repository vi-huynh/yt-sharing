module Session
  class SessionInvalid < StandardError; end

  class Base
    def initialize(email, password)
      @email    = email
      @password = password
    end

    def call
      raise(SessionInvalid, I18n.t('session.invalid_credentials')) if construct_session.nil?
      access_token, refresh_token = Jwt::Issuer.new(construct_session).()

      [access_token, refresh_token]
    rescue SessionInvalid => e
      raise
    rescue => e
      raise(StandardError, e.message)
    end

    private

    def construct_session
      return @construct_session if defined?(@construct_session)
      # byebug
      user = User.find_by(email: @email)
      @construct_session = user.present? && user.authenticate(@password) ? user : nil
    end
  end
end
