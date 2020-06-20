class TypingNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "typing_#{ params[:conversation_id] }_#{ params[:user_id] }_notification_channel"
  end

  def unsubscribed
  end

  def typing(data)
    ActionCable.server.broadcast "typing_#{ params[:conversation_id] }_#{ params[:user_id] }_notification_channel", typing: data['typing_status']
  end

end
