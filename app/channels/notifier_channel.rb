class NotifierChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    stream_from("notifications")
  end

  def unsubscribed
    stop_all_streams
  end
end
