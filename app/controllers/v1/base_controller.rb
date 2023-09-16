module V1
  class BaseController < ApplicationController
    include ActionController::Cookies
    include V1::ExceptionHandler
    include V1::ResponseSerializer
    include V1::AuthProtector
    include Pagy::Backend
  end
end
