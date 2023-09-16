module V1
  class FeedsController < V1::BaseController
    def unread
      json_response(current_user&.unread_notifcations || 0)
    end

    def read_all
      Feed.where(user_id: current_user.id).update_all(confirmed_at: Time.now)

      json_response({})
    rescue
      json_response({}, 400)
    end
  end
end
