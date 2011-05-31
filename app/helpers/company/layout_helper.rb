module Company::LayoutHelper
  def background_small_list
    list = []
    if @layout
      @layout.backgrounds.each { |background|
        list.push(Hash["#{URI::escape(background.my_background.url(:original))}", background.id ])
        #list << URI::escape(background.my_background.url(:small))
      }
    end
    images_list("public/images/company/layout/background_small/*",list)
  end

  def background_style_div
    style =''
    style << "background-color: ##{@layout.color.background}; background-image: url(#{@layout.background_file_name.nil? ? "" : @layout.background_file_name});"
    if @layout.repeat_background_x && @layout.repeat_background_y
      style << " background-repeat: repeat;"
    elsif !@layout.repeat_background_x && !@layout.repeat_background_y
      style << " background-repeat: no-repeat;"
    else
      style << " background-repeat: repeat-x; " if @layout.repeat_background_x
      style << " background-repeat: repeat-y; " if @layout.repeat_background_y
    end
    if @layout.centralize_background
      style << "background-position: top center;"
    else
      style << "background-position: top left;"
    end
    style
  end

  def background_top_small_list
    list = []
    if @layout
      @layout.background_tops.each do |top|
        list.push(Hash["#{URI::escape(top.background_top.url(:original))}", top.id ])
      end
    end
    images_list("public/images/company/layout/background_top_small/*",list)
  end

  def style_background
    style = "background-color:##{@layout.color.background};"
    style << "background-image: url(#{@layout.background_file_name});"
    if !@layout.repeat_background_x && !@layout.repeat_background_y
      style << "background-repeat: no-repeat;"
    elsif !@layout.repeat_background_x || !@layout.repeat_background_y
      style << " background-repeat: repeat-x; " if @layout.repeat_background_x
      style << " background-repeat: repeat-y; " if @layout.repeat_background_y
    end
    if @layout.centralize_background
      style << "background-position: top center;"
    else
      style << "background-position: top left;"
    end
    style
  end

  private

  def images_list(url,append=nil)
    list = Dir.glob url
    list.each{|p| p.gsub! "public",""}
    append.each { |e| list << e  } unless append.nil? || append.empty?
    list
  end
end
