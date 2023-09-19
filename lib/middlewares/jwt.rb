module Middlewares
  class JWT
    def initialize(app)
      @app = app
    end

    def call(env)
      return call_next(env) if env['REQUEST_PATH']&.match(/\/auth\/?/) && env['REQUEST_METHOD']&.eql?('POST')
      request_cookies = Rack::Utils.parse_cookies(env)

      return call_next(env) unless request_cookies.present?
      jwt_token = request_cookies['access_token']

      return call_next(env) unless jwt_token.present?
      set_env_variables(jwt_token, env)

      call_next(env)
    end

    private

    def call_next(env)
      @app.call(env)
    end

    def request_with_cookies(env)
      request = Rack::Request.new(env)
      cookies = request.env['action_dispatch.cookies']

      cookies['access_token']
    end

    def set_env_variables(token, env)
      jwt = Jwt::Decoder.new(token).()
      return unless jwt.present?

      env['jwt.sleeping_user_id'] = jwt[:user_id]
    end
  end
end
