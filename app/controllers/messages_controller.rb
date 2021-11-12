class MessagesController < ApplicationController
  before_action :require_user

  #firstly in the form, we're now going to send an ajax request?
  def create
    message = current_user.messages.build(message_params)
    if message.save
      #broadcast to channel, which we called chatroom channel
      #instead of broadcasting some data, we're going to broadcast a partial and append it to the messages component
      ActionCable.server.broadcast "chatroom_channel",
              mod_message: message_render(message)
      # redirect_to root_path
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def message_render(message)
    render(partial: 'message', locals: {message: message})
  end
end
