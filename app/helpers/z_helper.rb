module ZHelper
  def create_tabs_inner_div(options={})
    tabs = ''
    @layout.tabs.each do |tab|
      tabs << link_to("<div class=\"#{options[:class]}\">#{tab.title}</div>",:action=>"index",:tab_id=>tab,:id=>@company.user.login)
    end
    tabs
  end

  def create_tabs_separator
    tabs = ''
    @layout.tabs_with_components.each do |tab|
      tabs << "<li #{@tab.eql?(tab) ? "class='current_page_item'" : ""}>#{link_to(tab.title,:action=>"index",:tab_id=>tab,:id=>@company.user.login)}</li>"
    end
    tabs
  end
end
