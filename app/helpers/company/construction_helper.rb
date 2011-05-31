module Company::ConstructionHelper
  def preview_description(component)
    if !component[:type].eql?("ComponentText")
      ""
    else
      text = (truncate(Nokogiri::HTML(component.description).inner_text,:length=>30))
      text.gsub!(/\"/,'\'')
      text.gsub!("\t",' ')
      text.strip!
      return text
    end
  end

  def create_json_ociosos
    components = []
    @components.each do |component|
      components << "{\"id\": \"#{component.id}\", \"titulo\": \"#{h component.title.blank?  ? "Sem Título" : truncate(component.title,:length=>15)}\", \"conteudo\": \"#{preview_description(component)}\", \"tipo\":\"#{I18n.t "type.#{component[:type]}"}\"}"
    end
    components.join(',')
  end

  def create_json_tab_components(tab_components,line)
    components = []
    tab_components.find(:all,:conditions=>{:line=>line}).each do |tab_component|
      components << "{\"id\":\"#{tab_component.component.id}\",\"column\": \"#{tab_component.column}\", \"titulo\": \"#{h tab_component.component.title.blank?  ? "Sem Título" : truncate(tab_component.component.title,:length=>15)}\", \"conteudo\": \"#{h preview_description(tab_component.component)}\", \"tipo\":\"#{ I18n.t("type.#{tab_component.component[:type]}")}\"}"
    end
    components.join(",")
  end

  def create_json_tab_line(tab_components)
    line = -1
    tabs = []
    tab_components.each do |tab_component|
      if line < tab_component.line
        tabs << "{\"id\": #{tab_component.line}, \"conteudo\":[#{create_json_tab_components(tab_components,tab_component.line)} ]}"
        line = tab_component.line
      end
    end
    tabs.join(',')
  end

  def create_json_tabs
    tabs = []
    @tabs.each do |tab|
      tabs << "{\"id\": \"#{tab.id}\", \"titulo\": \" #{h truncate(tab.title,:length=>15)} \", \"conteudoAtivo\":[#{create_json_tab_line tab.tab_components}]}"
    end
    tabs.join(',')
  end
end
