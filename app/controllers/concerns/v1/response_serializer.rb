module V1
  module ResponseSerializer
    def json_response(object, status = :ok)
      render json: object, status: status
    end
  end
end
