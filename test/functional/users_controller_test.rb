require File.dirname(__FILE__) + '/../test_helper'
require 'users_controller'

# Re-raise errors caught by the controller.
class UsersController; def rescue_action(e) raise e end; end

class UsersControllerTest < ActionController::TestCase
  include AuthenticatedTestHelper
  

  def setup
    login_as :admin
  end
  # Liberar quando o cadastro estiver liberado para o público
  #  def test_should_allow_signup
  #    assert_difference 'User.count' do
  #      create_user
  #    end
  #    assert_redirected_to login_path
  #    assert_equal "Obrigado por se cadastrar! Por favor cheque seu email para ativar sua conta e se logar no sistema.", flash[:notice]
  #  end

  def test_should_allow_signup_logged_admin
    assert_difference 'User.count' do
      create_user
    end
    assert_response :success
    assert assigns(:users)
    assert_equal users(:admin),assigns(:user).person.user_create, "Erro com o usuário de criação"
    assert_equal users(:admin),assigns(:user).person.user_confirm, "Erro com o usuário de confirmação"
    assigns(:user).reload
    assert assigns(:user).activated_at
    assert_equal "Obrigado por se cadastrar! Por favor cheque seu email para ativar sua conta e se logar no sistema.", flash[:notice]
  end


  def test_new
    get :new
    assert assigns(:user)
    assert assigns(:person)
  end
    

  def test_should_require_login_on_signup
    login_as :quentin
    assert_no_difference 'User.count' do
      create_user(:login => nil)
      assert assigns(:user).errors.on(:login)
      assert_response :success
    end
  end

  def test_should_require_password_on_signup
    login_as :quentin
    assert_no_difference 'User.count' do
      create_user(:password => nil)
      assert assigns(:user).errors.on(:password)
      assert_response :success
    end
  end

  def test_should_require_password_confirmation_on_signup
    login_as :quentin
    assert_no_difference 'Address.count' do
      assert_no_difference 'User.count' do
        create_user(:password_confirmation => nil)
        assert assigns(:user).errors.on(:password_confirmation)
        assert_response :success
      end
    end
  end

  def test_should_require_email_on_signup
    login_as :quentin
    assert_no_difference 'User.count' do
      create_user(:email => nil)
      assert assigns(:user).errors.on(:email)
      assert_response :success
    end    
  end
  
  def test_should_sign_up_user_with_activation_code
    login_as :quentin
    create_user
    assigns(:user).reload
    assert_not_nil assigns(:user).activation_code
    assert assigns(:user).activated_at
  end

  def test_should_sign_up_user_with_web_administrator
    login_as :quentin
    create_user
    assigns(:user).reload
    assert_not_nil assigns(:user)
    assert_equal users(:quentin), assigns(:person).web_adm
    assert assigns(:user).activated_at
  end

  def test_should_not_signup_user_without_person
    login_as :quentin
    post :create, {:user => { :login => 'quire', :email => 'quire@example.com',
        :password => 'quire', :password_confirmation => 'quire' },:person=>{},:type=>UserAdministrator.name}
    assert_response :success
    assert !assigns(:person).valid?
    assert_equal  flash[:error], "Houve um problema criando sua conta."
  end

  def test_should_sign_up_user_without_web_administrator
    create_user
    assigns(:user).reload
    assert_not_nil assigns(:user)
    assert_nil assigns(:person).web_adm
  end


  def test_should_update
    login_as :quentin
    get :update,{:user=>{:login=>"quentin2"}}
    assert_equal "Usuário Atualizado", flash[:notice]
    assert_redirected_to root_path
  end
  
  def test_should_fail_update
    login_as :gerente_segmento
    get :update,{:user=>{:login=>""}}
    assert_equal "Ocorreram Erros ao Alterar a Senha", flash[:notice]
    assert_response :success
  end
  
  def test_should_signup_company
    login_as :gerente_segmento
    assert_difference("Address.count", 2) do
      assert_difference("User.count", 1) do
        post :create, {:user => { :login => 'quire', :email => 'quire@example.com',
            :password => 'quire', :password_confirmation => 'quire' },
          :company_type=>"CompanyZ",:company=>{:value=>50.1,:parcel=>12,:razao_social=>'Empresa',:cnpj=>'61.286.834/0001-08', :informal=>"0",:segment_id=>1
          },:address=>{:neighborhood=>'MySring', :state=>'AC',
            :city=> 'MyString', :zip=> 'MyString', :number=> '1111', :street=> 'MyString'},
          :person=>{:name=>'Bruno Siqueira',:cpf=>'034.185.221-06',  :rg=> 'MyString',
            :rg_exp=> 'MyString', :rg_exp_date=> '2008-09-09', :date_birth=> '2008-09-09'},:type=>UserCompany.name}
      end
    end
    assert_response :success
    assert_equal users(:gerente_segmento), assigns(:user).person.user_create, "Erro no usuário de criação"
    assert_equal people(:gerente_segmento).subsidiary, assigns(:user).person.subsidiary
    assert_nil flash[:error]
    assert assigns(:company).valid?
    assert assigns(:person).valid?
    assert assigns(:user).valid?
    assert assigns(:sellers)
    assert assigns(:sellers).include? people(:gerente_segmento)
  end

  def test_should_signup_company_s_no_cpf
    login_as :gerente_segmento
    assert_difference("User.count", 1) do
      post :create, {:user => { :login => 'quire', :email => 'quire@example.com',
          :password => 'quire', :password_confirmation => 'quire' },
        :company=>{:razao_social=>'Empresa',:cnpj=>'61.286.834/0001-08',:informal=>"0",:segment_id=>1},
        :address=>{:neighborhood=>'MySring', :state=>'RJ',
          :city=> 'MyString', :zip=> 'MyString', :number=> '1111', :street=> 'MyString'},
        :person=>{:name=>'Bruno Siqueira',  :rg=> 'MyString',
          :rg_exp=> 'MyString', :rg_exp_date=> '2008-09-09', :date_birth=> '2008-09-09'
        },:type=>UserCompany.name}
    end
    assert_response :success
    assert_equal users(:gerente_segmento), assigns(:user).person.user_create, "Erro no usuário de criação"
    assert_equal people(:gerente_segmento).subsidiary, assigns(:user).person.subsidiary
    assert_nil flash[:error]
    assert assigns(:company).valid?
    assert assigns(:person).valid?
    assert assigns(:user).valid?
    assert assigns(:sellers)
    assert assigns(:sellers).include? people(:gerente_segmento)
  end

  def test_should_not_signup_company_z_no_cpf
    login_as :gerente_segmento
    assert_difference("Person.count", 0) do
      post :create, {:user => { :login => 'quire', :email => 'quire@example.com',
          :password => 'quire', :password_confirmation => 'quire' },
        :company=>{:parcel=>12,:value=>50.0,:razao_social=>'Empresa',:cnpj=>'61.286.834/0001-08',
          :informal=>"0",:segment_id=>1 },
        :address=>{:neighborhood=>'MySring', :state=>'RJ',
          :city=> 'MyString', :zip=> 'MyString', :number=> '1111', :street=> 'MyString'},
        :person=>{:name=>'Bruno Siqueira',  :rg=> 'MyString',
          :rg_exp=> 'MyString', :rg_exp_date=> '2008-09-09', :date_birth=> '2008-09-09'
        },:type=>UserCompany.name,
        :company_type=>CompanyZ.name}
    end
    assert_response :success
    assert_equal "Houve um problema criando sua conta.", flash[:error]
    assert assigns(:company).valid?
    assert !assigns(:person).valid?
    assert assigns(:user).valid?
  end


  def test_should_signup_segment_manager_no_cpf
    assert_difference("User.count", 0) do
      post :create, {:user => { :login => 'quire', :email => 'quire@example.com',
          :password => 'quire', :password_confirmation => 'quire' },
        :person=>{:name=>'Bruno Siqueira', :rg=> 'MyString',
          :rg_exp=> 'MyString', :rg_exp_date=> '2008-09-09', :date_birth=> '2008-09-09'},:type=>UserSegmentManager.name}
    end
    assert_response :success
    assert assigns(:user).valid?
    assert !assigns(:person).valid?
    assert_equal "Houve um problema criando sua conta.", flash[:error]
  end

  def test_should_signup_segment_manager_cpf_blank
    assert_difference("Person.count", 0) do
      post :create, {:user => { :login => 'quire', :email => 'quire@example.com',
          :password => 'quire', :password_confirmation => 'quire' },
        :person=>{:cpf=>"",:name=>'Bruno Siqueira', :rg=> 'MyString',
          :rg_exp=> 'MyString', :rg_exp_date=> '2008-09-09', :date_birth=> '2008-09-09'},:type=>UserSegmentManager.name}
    end
    assert_response :success
    assert assigns(:user).valid?
    assert !assigns(:person).valid?
    assert_equal "Houve um problema criando sua conta.", flash[:error]
  end

  def test_should_signup_company_informal
    login_as :gerente_segmento
    assert_difference("User.count", 1) do
      post :create, {:user => { :login => 'quire', :email => 'quire@example.com',
          :password => 'quire', :password_confirmation => 'quire' },
        :company=>{:razao_social=>'Empresa',:informal=>"1",:segment_id=>1},
        :address=>{:neighborhood=>'MySring', :state=>'AC',
          :city=> 'MyString', :zip=> 'MyString', :number=> '1111', :street=> 'MyString'},
        :person=>{:name=>'Bruno Siqueira',:cpf=>'099.033.907-69',  :rg=> 'MyString',
          :rg_exp=> 'MyString', :rg_exp_date=> '2008-09-09', :date_birth=> '2008-09-09'},:type=>UserCompany.name}
    end
    assert_response :success
    assigns(:company).valid?
    assert_equal users(:gerente_segmento), assigns(:user).person.user_create, "Erro no usuário de criação"
    assert_equal people(:gerente_segmento).subsidiary, assigns(:user).person.subsidiary
  end

  def test_should_signup_company_formal_fail
    login_as :gerente_segmento
    assert_difference("Company.count", 0) do
      post :create, {:user => { :login => 'quire', :email => 'quire@example.com',
          :password => 'quire', :password_confirmation => 'quire' },
        :company=>{:razao_social=>'Empresa',:segment_id=>1},:address=>{:neighborhood=>'MySring', :state=>'AC',
          :city=> 'MyString', :zip=> 'MyString', :number=> '1111', :street=> 'MyString'},
        :person=>{:name=>'Bruno Siqueira',:cpf=>'099.033.907-69',  :rg=> 'MyString',
          :rg_exp=> 'MyString', :rg_exp_date=> '2008-09-09', :date_birth=> '2008-09-09'},:type=>UserCompany.name,:company_type=>CompanyZ.name}
    end
    assert_response :success
    assert !assigns(:company).valid?
    assert_equal users(:gerente_segmento), assigns(:person).user_create, "Erro no usuário de criação"
    assert_equal people(:gerente_segmento).subsidiary, assigns(:person).subsidiary
  end

  def test_should_fail_signup_company_inconsistence
    login_as :gerente_segmento
    post :create, {:user => { :login => 'quire', :email => 'quire@example.com',
        :password => 'quire', :password_confirmation => 'quire' },      
      :person=>{:name=>'Bruno Siqueira',:cpf=>'099.033.907-69', :rg=> 'MyString',
        :rg_exp=> 'MyString', :rg_exp_date=> '2008-09-09', :date_birth=> '2008-09-09'  },:type=>UserCompany.name}
    assert_response :success
    assert_equal "Houve um problema criando sua conta.",flash[:error]
  end

  def test_create_user_with_existing_person
    post :create, {:user => { :login => 'quire', :email => 'quire@example.com',
        :password => 'quire', :password_confirmation => 'quire' },
      :person=>people(:gerente_geral).attributes,:type=>UserAdministrator.name
    }
    assert User.find_by_login "quire"
  end

  def test_create_user_with_existing_person_different_subsidiary
    login_as :gerente_geral
    post :create, {:user => { :login => 'quire', :email => 'quire@example.com',
        :password => 'quire', :password_confirmation => 'quire' },
      :person=>people(:empresa_valid).attributes,:type=>UserAdministrator.name
    }
    assert_nil User.find_by_login "quire"
  end


  def test_destroy_successfull
    assert_difference("User.count",-1) do
      get :destroy,:id=>users(:gerente_geral_2).id
    end
  end

  def test_destroy_successfull_for_gerente_segmento
    login_as :gerente_segmento
    assert_difference("User.count",-1) do
      get :destroy,:id=>users(:gerente_geral_2).id
    end
  end


  def test_destroy_successfull_for_admin_and_activated_user
    assert_difference("User.count",-1) do
      get :destroy,:id=>users(:empresa_valid_2)
    end
    assert_nil flash[:notice]
  end

  def test_destroy_fail_for_gerente_segmento
    login_as :gerente_segmento
    assert_difference("User.count",0) do
      get :destroy,:id=>users(:empresa_valid_2)
    end
    assert_equal "O usuário já foi ativado e não pode mais ser excluído.", flash[:notice]
  end

  def test_destroy_fail_for_company_with_titles
    assert_difference("User.count",0) do
      get :destroy,:id=>users(:empresa_valid)
    end
    assert_redirected_to :action => "index"
  end

  def test_create_page_2
    post :create_page_2, {:id=>users(:empresa_valid).id,
      :company=>{:person_id=>people(:admin_web).id},
      :person=>{:user_web_adm_id=>users(:admin_web)}}
    assert_redirected_to :action => "index"
    assert_equal users(:admin_web),assigns(:user).person.web_adm
    assert_equal people(:admin_web),assigns(:user).company.seller
  end

  def test_should_resend_signup_mail
    get :resend_signup_mail,:id=>users(:gerente_geral)
    assert_redirected_to :action => "index"
    assert_equal "O e-mail de ativação foi reenviado para o usuário gerente_geral (a senha não será exibida no e-mail)",flash[:notice]
  end

  def test_should_not_resend_signup_mail
    get :resend_signup_mail,:id=>users(:gerente_segmento)
    assert_redirected_to :action => "index"
    assert_equal "O usuário gerente_segmento já está ativo e não pode receber um segundo e-mail de ativação",flash[:error]
  end

  def test_new_company
    get :new, :type=>UserCompany.name
    assert_response :success
  end

  def test_new_comercial
    get :new
    assert_response :success
  end

  protected
  def create_user(options = {})
    post :create, {:user => { :login => 'quire', :email => 'quire@example.com',
        :password => 'quire', :password_confirmation => 'quire' }.merge(options),
      :person=>{:name=>'Bruno Siqueira',:cpf=>'356.726.002-20', :rg=> 'MyString',
        :rg_exp=> 'MyString', :rg_exp_date=> '2008-09-09', :date_birth=> '2008-09-09',:subsidiary_id=>1},
      :type=>UserAdministrator.name
    }
  end

end
