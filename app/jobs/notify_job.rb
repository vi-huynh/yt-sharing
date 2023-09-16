class NotifyJob < ApplicationJob
  sidekiq_options queue: :notifier

  def perform(link_id)
    link = Link.find_by(id: link_id)

    ActionCable.server.broadcast("notifications", { **link.attributes, shared_by: link.sharer&.email })
  end
end
