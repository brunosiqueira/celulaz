ActionController::Routing::Routes.draw do |map|
  map.resources :template_texts
  #messaging system
  map.localized([I18n.locale], :verbose =>true) do
    map.namespace :financial do |financial|
      financial.resources :shippings
      financial.resources :companies, :has_many=>:titles
    end
    map.namespace :company do |comp|
      comp.resources :messages, :member => { :reply => :post }
      comp.resources :users
      comp.resources :banners
      comp.resources :businesses
      comp.resources :people
      comp.resources :components do |components|
        components.resources :pictures
      end
      comp.resources :sent, :mailbox
      comp.resources :phones
    end

    map.resources :messages
  
    #javascript
    map.connect "/company/contacts.js", :controller => "company/contacts", :action => 'index'
    map.connect "/company/relationships/suggestions/:company_id.:format", :controller => "company/relationships", :action => 'suggestions'
  
    map.connect '/busca-empresa/:search/:segment_id/:page', :controller => "company_search", :action => "index", :conditions => { :method => :get }
    map.resources :company_to_friend
    map.resources :business_cards
    map.resources :colors
    map.resources :businesses
    map.resources :people
    map.resources :subsidiaries
    map.resources :layouts
    map.resources :companies, :has_many => :contracts

    
    map.root :controller => "main",:action=>"index"
    map.who '/quem-somos',:controller => "main",:action=>"who"
    map.advantages '/vantagens',:controller => "main",:action=>"advantages"
    map.contact_us '/fale-conosco',:controller => "contacts",:action=>"new"
    map.visit_scheduler '/agendar-visita',:controller => "visit_scheduler",:action=>"new"
    map.search '/busca', :controller => "search"
    map.component_update '/component_update', :controller => "company/components",:action=>"update"
    map.component_create '/component_create', :controller => "company/components",:action=>"create"
    map.company_root '/empresa-inicio',:controller=>"company/profile"
    map.company_construction '/empresa/construcao',:controller=>"company/construction"
    map.company_identity '/empresa/identidade/:action',:controller=>"company/identity"
    map.company_business_card '/empresa/cartao-de-visitas', :controller=>"company/business_card"
    map.inbox '/empresa/mensagens/entrada', :controller => 'company/mailbox', :action => 'index'
    map.company_relationships '/empresa/relacionamentos', :controller => 'company/relationships'
    map.signup '/signup', :controller => 'users', :action => 'new'
    map.login '/login', :controller => 'main'
    map.logout '/logout', :controller => 'sessions', :action => 'destroy'
    map.activate '/ativar/:id', :controller => 'accounts', :action => 'show'
    map.forgot_password '/esqueci-a-senha', :controller => 'passwords', :action => 'new'
    map.reset_password '/reiniciar-senha/:id', :controller => 'passwords', :action => 'edit'
    map.change_password '/alterar-senha', :controller => 'accounts', :action => 'edit'
    map.z '/z/:id', :controller => 'z', :action => 'index'
    map.z_component '/z/componentes/:id/:component_id', :controller => 'z', :action => 'component'
    map.titles_not_payed '/titulos-nao-pagos', :controller => 'financial/titles_not_payed', :action => 'index'
  
    # See how all your routes lay out with "rake routes"
    map.resources :pages
  
    map.resources :users, :member => { :enable => :put, :disable=>:delete } do |users|
      users.resource :account
    end
  
    map.resource :session
    map.resource :password
  end
  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action.:format'
end
