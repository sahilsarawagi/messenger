class MessageChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from 'message'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
  def receive(data)
    if current_user
      data['user'] = current_user
    else
      data['user'] = {email: "anonymous"}
    end
    ActionCable.server.broadcast('message', data)
  end
end
