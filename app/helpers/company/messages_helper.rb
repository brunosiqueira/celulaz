module Company::MessagesHelper
  
  def show_sent_message(message)
    content = '<div class="item-read"><div class="sender-info">'
    content << '<div style="height: 12px; background: url(../../images/new_version/ico-msg-color.gif) no-repeat scroll -3px -5px transparent; height: 12px; width: 20px; margin-right:5px; float:left;" ></div>'
    if message.is_external?
      content << message.sender_email
		else
			content << message.sender.login
		end
		content << '<div class="date">'
    content << I18n.localize(message.updated_at, :format => :long)
    content << '</div></div><div class="content">'
    content << message.body
    content << '</div></div>'
    return content
  end
  
  def show_received_message(message)
    content = '<div class="item-read"><div class="sender-info">'
    content << '<div style="height: 12px; background: url(../../images/new_version/ico-msg-color.gif) no-repeat scroll -3px -5px transparent; height: 12px; width: 20px; margin-right:5px; float:left;" ></div>'
    if message.message.is_external?
      content << message.message.sender_email
		else
			content << message.sender.login
		end
		content << '<div class="date">'
    content << I18n.localize(message.updated_at, :format => :long)
    content << '</div></div><div class="content">'
    content << message.body
    content << '</div></div>'
    return content
  end
end