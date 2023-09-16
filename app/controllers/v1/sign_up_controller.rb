module V1
  class SignUpController < V1::BaseController
    skip_before_action :authorize_request, only: :create

    def create
      user = User.new(sign_up_params)

      return json_response({ message: 'Success'}) if user.save

      json_response({ message: user.errors.full_messages }, 400)
    end

    private

    def sign_up_params
      params.permit(:email, :password, :password_confirmation)
    end
  end
end
