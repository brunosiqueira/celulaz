# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  MENU_CONTROLLERS = {
    :initial=>%w(company/profile),
    :site=>%w(company/construction company/identity company/banners company/contacts company/seo),
    :card=>%w(company/business_card),
    :business=>%w(company/businesses),
    :mail=>%w(company/mailbox company/messages company/sent),
    :relationships=>%w(company/relationships),
    :company=>%w(company/users company/people financial/titles_not_payed)
  }

  def recover_url_image_code(url)
    CGI::parse(URI.parse(url).query)["v"]
  rescue NoMethodError
    URI.parse(url).path.split('/').last
  end

  def active_tab(index)
    return "class='active'" if MENU_CONTROLLERS[index].include? params[:controller]
  end

  def self.humanize_user(type)
    I18n.t("user.#{type}")
  end
  
  def self.humanize_company(type)
    I18n.t("user.#{type}")
  end

  def loading(name="loading")
    style_loading = "display:none;position:absolute;top:0;left:0;width:100%;height:100%;z-index:5000;background-image: url(#{image_path 'back.gif'});opacity: .6; filter: alpha(Opacity=60); -khtml-opacity: .6;"
    style_loading_image="position: absolute;top:50%;left:50%;z-index:9999;width:32px;height:32px;margin:-16px 0 0 -16px;background-image: url(#{image_path 'redbox_spinner.gif'});"
    return "<div id=\"#{name}\" style=\"#{style_loading}\"><div id=\"loading_image\" style=\"#{style_loading_image}\"></div></div>"
  end

  def self.show_web_adm(person)
    web_adm = person.web_adm
    return web_adm.nil? ? "" : " - Adm: #{web_adm.person.name}" 
  end

  def not_nil_label
    "<b style=\"color:red\">*</b>"
  end

  def analytics_script
    return "" if RAILS_ENV != "production"
    return "<script type=\"text/javascript\">
      var _gaq = _gaq || [];_gaq.push([\'_setAccount\', \'UA-11343672-4\']);_gaq.push([\'_trackPageview\']);
      (function() {
       var ga = document.createElement(\'script\'); ga.type = \'text/javascript\'; ga.async = true;
       ga.src = (\'https:\' == document.location.protocol ? \'https://ssl\' : \'http://www\') + \'.google-analytics.com/ga.js\';
       var s = document.getElementsByTagName(\'script\')[0]; s.parentNode.insertBefore(ga, s);
      })();
      </script>
      <script type=\"text/javascript\">
        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-21506634-1']);
        _gaq.push(['_trackPageview']);
        (function() {
          var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
          ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
          var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();

      </script>"
  end

  def google_add_bar
    return  '<script type="text/javascript"><!--
                google_ad_client = "ca-pub-7834145211867769";
                /* Busca Célula Z */
                google_ad_slot = "1335036644";
                google_ad_width = 160;
                google_ad_height = 600;
                //-->
                </script>
                <script type="text/javascript"
                src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
                </script>'
  end
  
  def title(page_title, show_title = true)
    content_for(:title, page_title.to_s)
    @show_title = show_title
  end
  
  def show_title?
    @show_title
  end
  
  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args.map(&:to_s)) }
  end
  
  def javascript(*args)
    args = args.map { |arg| arg == :defaults ? arg : arg.to_s }
    content_for(:head) { javascript_include_tag(*args) }
  end

  def default_content_for(name, &block)
    name = name.kind_of?(Symbol) ? ":#{name}" : name
    out = eval("yield #{name}", block.binding)
    concat(out || capture(&block), block.binding)
  end

  def image_height(path)
    path = "/#{path}" unless "/".eql?(path[0,1])  
    Paperclip::Geometry.from_file(File.new(URI::unescape("public#{path.sub(/\?[0-9]+/, '')}"),"r")).to_s.split("x")[1]
  rescue
  end

  def remove_tags(text)
    Nokogiri::HTML(text).inner_text
  end

  def html_truncate(input, num_words = 15, truncate_string = "...")
    return "" if input.blank?
    doc = Nokogiri::HTML(input)
    
    current = doc.children.first
    count = 0

    while true
      # we found a text node
      if current.is_a?(Nokogiri::XML::Text)
        count += current.text.split.length
        # we reached our limit, let's get outta here!
        break if count > num_words
        previous = current
      end

      if current.children.length > 0
        # this node has children, can't be a text node,
        # lets descend and look for text nodes
        current = current.children.first
      elsif !current.next.nil?
        #this has no children, but has a sibling, let's check it out
        current = current.next
      else
        # we are the last child, we need to ascend until we are
        # either done or find a sibling to continue on to
        n = current
        while !n.is_a?(Nokogiri::HTML::Document) and n.parent.next.nil?
          n = n.parent
        end

        # we've reached the top and found no more text nodes, break
        if n.is_a?(Nokogiri::HTML::Document)
          break;
        else
          current = n.parent.next
        end
      end
    end

    if count >= num_words
      unless count == num_words
        new_content = current.text.split

        # If we're here, the last text node we counted eclipsed the number of words
        # that we want, so we need to cut down on words.  The easiest way to think about
        # this is that without this node we'd have fewer words than the limit, so all
        # the previous words plus a limited number of words from this node are needed.
        # We simply need to figure out how many words are needed and grab that many.
        # Then we need to -subtract- an index, because the first word would be index zero.

        # For example, given:
        # <p>Testing this HTML truncater.</p><p>To see if its working.</p>
        # Let's say I want 6 words.  The correct returned string would be:
        # <p>Testing this HTML truncater.</p><p>To see...</p>
        # All the words in both paragraphs = 9
        # The last paragraph is the one that breaks the limit.  How many words would we
        # have without it? 4.  But we want up to 6, so we might as well get that many.
        # 6 - 4 = 2, so we get 2 words from this node, but words #1-2 are indices #0-1, so
        # we subtract 1.  If this gives us -1, we want nothing from this node. So go back to
        # the previous node instead.
        index = num_words-(count-new_content.length)-1
        if index >= 0
          new_content = new_content[0..index]
          current.content = new_content.join(' ') + truncate_string
        else
          current = previous
          current.content = current.content + truncate_string
        end
      end

      # remove everything else
      while !current.is_a?(Nokogiri::HTML::Document)
        while !current.next.nil?
          current.next.remove
        end
        current = current.parent
      end
    end

    # now we grab the html and not the text.
    # we do first because nokogiri adds html and body tags
    # which we don't want
    #debugger
    doc.root.children.first.inner_html
    #doc.inner_html
  end

  def site_path(user)
    if user.domain.blank?
      return "http://#{SITE_URL}/sites/#{CGI::escape user.login}/"
    else
      return "http://#{user.domain}"
    end
  end

end
