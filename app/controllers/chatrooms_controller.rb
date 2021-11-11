class ChatroomsController < ApplicationController
  before_action :require_user
  
  def index
    @message = Message.new
    @messages = Message.all.order(:id)
  end
end
