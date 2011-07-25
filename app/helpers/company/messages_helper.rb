module Company::MessagesHelper
  
  def show_sent_message(message)
    content = '<div class="item-read"><div class="sender-info">'
    content << '<div style="height: 12px; background: url(../../images/new_version/ico-msg-color.gif) no-repeat scroll -3px -5px transparent; height: 12px; width: 20px; margin-right:5px; float:left;" ></div>'
    if message.is_external?
      content << message.sender_email
		else
			content << link_to(message.sender_name, system_modules_profile_path(message.sender.company))
		end
		content << '<br /><div class="date">'
    content << I18n.localize(message.created_at, :format => :long)
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
		  if message.sender.nil?
		    content << '<span>Não foi possível localizar o remetente.</span>'
		  else
			  content << link_to(message.sender_name, system_modules_profile_path(message.sender.company))
			end
		end
		content << '<br /><div class="date">'
    content << I18n.localize(message.created_at, :format => :long)
    content << '</div></div><div class="content">'
    content << message.body
    content << '</div></div>'
    return content
  end
end