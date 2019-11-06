class MessageNotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversation_#{ params[:conversation_id] }_notification_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
