class UserNotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_#{ params[:user_id] }_notification_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
