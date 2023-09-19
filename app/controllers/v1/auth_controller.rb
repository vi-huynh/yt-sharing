module V1
  class AuthController < V1::BaseController
    skip_before_action :authorize_request, only: [:create, :update]

    def show
      user_json = V1::MeSerializer.new(current_user).serializable_hash

      json_response(user_json)
    end

    def create
      access_token, refresh_token = Session::Base.new(
        auth_params[:email],
        auth_params[:password]
      ).()

      set_access_token(access_token)
      set_refresh_token(refresh_token)

      json_response(message: 'Success', access_token: access_token, refresh_token: refresh_token)
    rescue Session::SessionInvalid => e
      render_400(e)
    rescue StandardError => e
      render_unexpected_error(e)
    end

    def update
      new_access_token, new_refresh_token = ::Jwt::Refresher.new(
        access_token: current_access_token,
        refresh_token: current_refresh_token
      ).()

      set_access_token(new_access_token)
      set_refresh_token(new_refresh_token)

      json_response({})
    end

    def destroy
      Token.find_by(crypted_token: cookies[:refresh_token])&.destroy!

      cookies.delete(:access_token)
      cookies.delete(:refresh_token)

      json_response({})
    end

    private

    def auth_params
      params.require(:auth).permit(:email, :password)
    end

    def current_access_token
      cookies[:access_token]
    end

    def current_refresh_token
      cookies[:refresh_token]
    end

    def set_access_token(token)
      cookies[:access_token] = {
        value: token,
        httponly: true
      }
    end

    def set_refresh_token(token)
      cookies[:refresh_token] = {
        value: token,
        httponly: true
      }
    end
  end
end
