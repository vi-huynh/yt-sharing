module V1
  module AuthProtector
    extend ActiveSupport::Concern

    included do
      before_action :authorize_request
    end

    attr_reader :current_user

    private

    def authorize_request
      raise(ExceptionHandler::AccessDenied, I18n.t('auth.invalid_token')) if user_session.blank?

      @current_user = user_session
    end

    def user_session
      user_session_by_jwt
    end

    def user_session_by_jwt
      return unless jwt_user_id.present?

      User.find_by(id: jwt_user_id)
    end

    def jwt_user_id
      request.env['jwt.sleeping_user_id']
    end
  end
end
