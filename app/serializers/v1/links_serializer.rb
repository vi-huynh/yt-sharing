module V1
  class LinksSerializer
    include FastJsonapi::ObjectSerializer

    attributes :id, :url

    attribute :shared_by do |object|
      object.sharer&.email
    end
  end
end
