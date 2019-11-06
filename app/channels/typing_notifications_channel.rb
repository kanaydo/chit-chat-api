class TypingNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "typing_#{ params[:conversation_id] }_#{ params[:user_id] }_notification_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
