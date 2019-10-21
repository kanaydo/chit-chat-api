class MessageNotificationChannel < ApplicationCable::Channel
  def subscribed message
    stream_from "conversation_#{ message.conversation_id }_#{ message.user_id }_notification_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
