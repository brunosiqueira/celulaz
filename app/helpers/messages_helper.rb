module MessagesHelper
  def menu_class(menu)
    if menu == "in"
      return @message_view == "received_messages" ? "selected" : ""
    else
      return @message_view == "sent_messages" ? "selected" : ""
    end
  end
end
