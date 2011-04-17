class Company::PublishController < ApplicationController
  include LoadMap
  before_filter :login_with_company_required, :except=>:publish_pending
  before_filter :login_with_company_z_required, :except=>:publish_pending
  before_filter :load_company, :except=>:publish_pending
 before_filter :check_comercial_user, :only=>:publish_pending
  layout nil
  PATH_SITES = "public/sites/"
  def create
    Dir::mkdir(PATH_SITES) unless File.directory?(PATH_SITES)
    # Incluir verificação de nomes reservados
    # Verifica se já existe a pasta e remove
    site_path = PATH_SITES+current_company.login
    if File.directory?(site_path)
      FileUtils::remove_dir(site_path,true)
      # Recria a pasta
    end
    @user = current_company
    Dir::mkdir(site_path)
    # Recupera os dados da empresa
    # Para cada aba
    @map = get_location(@layout.address_site.to_s)
    File.open site_path +"/show.html","w+" do |f|
      content_map = render_to_string(:template=>"/company/publish/show.html",:layout=>false,:locals=>{:map=>@map})
      f.write content_map
    end
    @layout.tabs_with_components.each do |tab|
      # Cria o html
      File.open site_path +"/index#{@layout.tabs_with_components.first == tab ? "" : tab.id}.html","w+" do |f|
        # Monta o menu com links para as páginas estaticas
        # Padrão de nomenclatura: primeira aba: index.html / outras index{aba.id}.html
        html_content = render_to_string(:content_type=>"html",:template=>"/company/publish/index.html",:layout=>"z/template#{@layout.architecture_type}.html",:locals=>{:map=>@map,:layout=>@layout,:tab_selected=>tab,:site_path=>site_path})
        content = Nokogiri::HTML(html_content)
        f.write content.to_s
      end
    end
    # Monta o componente.
    # Se tiver o "Ver mais", montar link para a tela estática dele.
    # Finaliza
    #Finaliza
    #Para cada componente
    @layout.components_expandable.each do |component|
      #se tiver o "ver mais"
      File.open site_path +"/conteudo#{component.id}.html","w+" do |f|
        #Montar a tela
        # Padrão de nomenclatura: conteudo{conteudo.id}.html\
        content = Nokogiri::HTML(render_to_string(:content_type=>"html",:template=>"/company/publish/#{component[:type].underscore}.html",:layout=>"z/template#{@layout.architecture_type}.html",:locals=>{:map=>@map,:layout=>@layout,:tab_selected=>component.tab_component.tab,:component=>component}))
        f.write content.to_s
      end
    end
    render :text=>"http://#{SITE_URL}/sites/#{current_company.login}/"
  end

   def publish_pending
    UserCompany.find(:all, :conditions=>"domain is not null").each do |user|
      Dir::mkdir(PATH_SITES) unless File.directory?(PATH_SITES)
      # Incluir verificação de nomes reservados
      # Verifica se já existe a pasta e remove
      site_path = PATH_SITES+user.login
      unless File.directory?(site_path)
        @user = user
        @company = user.company
        @layout = @company.layout
        Dir::mkdir(site_path)
        # Recupera os dados da empresa
        # Para cada aba
        @map = get_location(@layout.address_site.to_s)
        File.open site_path +"/show.html","w+" do |f|
          content_map = render_to_string(:template=>"/company/publish/show.html",:layout=>false,:locals=>{:map=>@map})
          f.write content_map
        end
        @layout.tabs_with_components.each do |tab|
          # Cria o html
          File.open site_path +"/index#{@layout.tabs_with_components.first == tab ? "" : tab.id}.html","w+" do |f|
            # Monta o menu com links para as páginas estaticas
            # Padrão de nomenclatura: primeira aba: index.html / outras index{aba.id}.html
            html_content = render_to_string(:content_type=>"html",:template=>"/company/publish/index.html",:layout=>"z/template#{@layout.architecture_type}.html",:locals=>{:map=>@map,:layout=>@layout,:tab_selected=>tab,:site_path=>site_path})
            content = Nokogiri::HTML(html_content)
            f.write content.to_s
          end
        end
        # Monta o componente.
        # Se tiver o "Ver mais", montar link para a tela estática dele.
        # Finaliza
        #Finaliza
        #Para cada componente
        @layout.components_expandable.each do |component|
          #se tiver o "ver mais"
          File.open site_path +"/conteudo#{component.id}.html","w+" do |f|
            #Montar a tela
            # Padrão de nomenclatura: conteudo{conteudo.id}.html\
            content = Nokogiri::HTML(render_to_string(:content_type=>"html",:template=>"/company/publish/#{component[:type].underscore}.html",:layout=>"z/template#{@layout.architecture_type}.html",:locals=>{:map=>@map,:layout=>@layout,:tab_selected=>component.tab_component.tab,:component=>component}))
            f.write content.to_s
          end
        end
      end
    end
    flash[:notice] = "Sites pendentes gerados com sucesso."
    redirect_to :controller=>"/domains", :action=>"index"
  end
end
