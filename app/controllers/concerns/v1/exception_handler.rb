module V1
  module ExceptionHandler
    extend ActiveSupport::Concern

    class AuthenticationError < StandardError; end
    class InvalidInput        < StandardError; end
    class AccessDenied        < StandardError; end

    included do
      rescue_from StandardError, with: :render_unexpected_error
      rescue_from ActionController::BadRequest, with: :render_400
      rescue_from AuthenticationError, with: :unauthorized_request
      rescue_from AccessDenied, with: :unauthorized_request
      rescue_from ActiveRecord::RecordInvalid, with: :render_422
      rescue_from InvalidInput, with: :render_400
    end

    private

    def render_unexpected_error(e)
      json_response({ message: e.message }, :internal_server_error)
    end

    def render_422(e)
      json_response({ message: e.message }, :unprocessable_entity)
    end

    def render_400(e)
      json_response({ message: e.message }, :bad_request)
    end

    def unauthorized_request(e)
      json_response({ message: e.message }, :unauthorized)
    end

    def record_errors(e)
      json_response({ message: e.record.errors.full_messages }, :unprocessable_entity)
    end

    def permission_denied(_e)
      json_response({ message: e.message }, :forbidden)
    end
  end
end
