module V1
  class MeSerializer
    include FastJsonapi::ObjectSerializer

    attributes :id, :email
  end
end
