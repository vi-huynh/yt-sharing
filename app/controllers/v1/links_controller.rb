module V1
  class LinksController < V1::BaseController
    DEFAULT_PAGE      = 1
    DEFAULT_PER_PAGE  = 10
    MAX_PER_PAGE      = 15
    def index
      pagy, links = pagy(Link.all.order(id: :asc), **pagy_params)
      links = links.map do |link|
        #V1::LinksSerializer.new(link).serializable_hash[:data][:attributes]
        data = link.attributes.slice('id', 'url', 'title', 'description')
        data[:shared_by] = link.sharer&.email

        data
      end

      json_response({ 
        pagy: { page: pagy.page, per_page: pagy.items, total: pagy.count, next_page: pagy.next, total_pages: pagy.pages }, 
        data: links 
      })
    rescue => e 
      json_response({message: e.message})
    end

    def create
      link = Link.create!(sharer_id: current_user.id, **link_params)

      NotifyJob.perform_async(link.id)
      json_response({ **link.attributes, share_by: link.sharer&.email })
    rescue StandardError => ex
      json_response({ message: ex.message }, 400)
    end

    private

    def link_params
      params.permit(:video_id, :url, :title, :description)
    end

    def pagy_params
      {
        page: params[:page]       || DEFAULT_PAGE,
        items: [(params[:per_page] || DEFAULT_PER_PAGE).to_i, MAX_PER_PAGE].min
      }
    end
  end
end
