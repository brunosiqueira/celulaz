require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead.
  # Then, you can remove it from this and the functional test.
  include AuthenticatedTestHelper
  fixtures :users

  def test_valid_login
    user = User.new :login=>"bruno com espaco"
    user.valid?
    assert user.errors.on :login
    user.login = "bruno_sem_espaco"
    user.valid?
    assert_nil user.errors.on :login
    user.login = "bruno-sem-espaco"
    user.valid?
    assert_nil user.errors.on :login
    user.login = "bruno12345434543comnumeros323"
    user.valid?
    assert_nil user.errors.on :login
    user.login = "comcaractéresespeciais"
    user.valid?
    assert user.errors.on :login
  end

  def test_should_create_user
    assert_difference 'User.count' do
      user = create_user
      assert !user.new_record?, "#{user.errors.full_messages.to_sentence}"
    end
  end

  def test_is_administrator
    assert users(:admin).is_administrator?
    assert ! users(:gerente_segmento).is_administrator?
  end

  def test_should_initialize_activation_code_upon_creation
    user = create_user
    user.reload
    assert_not_nil user.activation_code
  end

  def test_should_require_login
    assert_no_difference 'User.count' do
      u = create_user(:login => nil)
      assert u.errors.on(:login)
    end
  end

  def test_should_require_password
    assert_no_difference 'User.count' do
      u = create_user(:password => nil)
      assert u.errors.on(:password)
    end
  end

  def test_should_require_password_confirmation
    assert_no_difference 'User.count' do
      u = create_user(:password_confirmation => nil)
      assert u.errors.on(:password_confirmation)
    end
  end

  def test_should_require_email
    assert_no_difference 'User.count' do
      u = create_user(:email => nil)
      assert u.errors.on(:email)
    end
  end

  def test_should_reset_password
    users(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal users(:quentin), User.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    users(:quentin).update_attributes(:login => 'quentin2')
    assert_equal users(:quentin), User.authenticate('quentin2', 'test')
  end

  def test_should_authenticate_user
    assert_equal users(:quentin), User.authenticate('quentin', 'test')
  end

  def test_should_set_remember_token
    users(:quentin).remember_me
    assert_not_nil users(:quentin).remember_token
    assert_not_nil users(:quentin).remember_token_expires_at
  end

  def test_should_unset_remember_token
    users(:quentin).remember_me
    assert_not_nil users(:quentin).remember_token
    users(:quentin).forget_me
    assert_nil users(:quentin).remember_token
  end

  def test_should_remember_me_for_one_week
    before = 1.week.from_now.utc
    users(:quentin).remember_me_for 1.week
    after = 1.week.from_now.utc
    assert_not_nil users(:quentin).remember_token
    assert_not_nil users(:quentin).remember_token_expires_at
    assert users(:quentin).remember_token_expires_at.between?(before, after)
  end

  def test_should_remember_me_until_one_week
    time = 1.week.from_now.utc
    users(:quentin).remember_me_until time
    assert_not_nil users(:quentin).remember_token
    assert_not_nil users(:quentin).remember_token_expires_at
    assert_equal users(:quentin).remember_token_expires_at, time
  end

  def test_should_remember_me_default_two_weeks
    before = 2.weeks.from_now.utc
    users(:quentin).remember_me
    after = 2.weeks.from_now.utc
    assert_not_nil users(:quentin).remember_token
    assert_not_nil users(:quentin).remember_token_expires_at
    assert users(:quentin).remember_token_expires_at.between?(before, after)
  end

  def test_has_manager_role
    assert users(:gerente_segmento).is_manager?
    assert !users(:empresa).is_manager?
  end

  test "should be invalid with invalid domain string" do
    user = users(:empresa_valid)
    user.domain = "*"
    assert !user.valid?
  end
  
  test "should be invalid with invalid www domain " do
    user = users(:empresa_valid)
    user.domain = "www.empresa.com"
    assert !user.valid?
  end
  
  test "should be invalid with invalid www and br domain" do
    user = users(:empresa_valid)
    user.domain = "www.empresa.com.br"
    assert !user.valid?
  end
  
  test "should be valid with *.com domain" do
    user = users(:empresa_valid)
    user.domain = "empresa.com"
    assert user.valid?
  end
  
  test "should be valid with *.com.br domain" do
    user = users(:empresa_valid)
    user.domain = "empresa.com.br"
    assert user.valid?
  end

  def test_randon_domain
    users(:empresa_valid).update_attribute :domain, "empresa.com"
    users(:empresa_valid).reload
    assert_equal "empresa.com",users(:empresa_valid).domain
  end
  
  def test_get_subusers_non_companies_admin
    users = User.find(:all,:conditions=>['id<>? and type<>?',users(:admin).id,UserCompany.name],:order=>"login")
    assert_equal users, users(:admin).get_subusers_non_companies
  end

  def test_get_subusers_companies_admin
    users = UserCompany.find(:all,:include=>:company,:order=>"companies.razao_social")
    assert_equal users.size, users(:admin).get_subusers_companies.size
  end

  def test_get_subusers_non_companies_gerente_segmento
    assert_equal UserSegmentManager, users(:gerente_segmento).class
    assert_equal 2, users(:gerente_segmento).get_subusers_non_companies.size
  end

  def test_get_subusers_companies_gerente_segmento
    assert_equal UserSegmentManager, users(:gerente_segmento).class
    assert_equal 1, users(:gerente_segmento).get_subusers_companies.size
  end

  def test_get_subusers_companies_adm_web
    assert_equal [users(:empresa)], users(:admin_web).get_subusers_companies
  end
  
  def test_polymorphic
    assert_equal UserAdministrator.name, users(:admin).class.name
    assert_equal UserWebAdministrator.name, users(:quentin).class.name
    assert_equal UserGeneralManager.name, users(:gerente_geral).class.name
    assert_equal UserSegmentManager.name, users(:gerente_segmento).class.name
    assert_equal UserCompany.name, users(:empresa).class.name
  end

  def test_subusers
    assert_equal [UserAdministrator.name, UserDirector.name,UserSupport.name,UserGeneralManager.name,
      UserSegmentManager.name,UserWebAdministrator.name,UserWebAdministratorSenior.name,
      UserWebAdministratorTrainee.name], users(:admin).subusers
    
  end

  def test_can_confirm
    assert users(:admin_web).can_confirm?(people(:empresa)), "Administrador web não pôde confirmar"
    assert users(:gerente_segmento).can_confirm?(people(:empresa_first_confirm)), "Gerente segmento não pôde confirmar"
    assert !users(:admin_web).can_confirm?(people(:empresa_first_confirm)), "Administrador web não pode confirmar"
  end

  def test_web_adm_confirm
    users(:admin_web).confirm people(:empresa)
    assert_equal people(:empresa).user_create,users(:admin_web)
    assert_equal people(:empresa).web_adm,users(:admin_web)
  end

  def test_get_companies
    assert_equal Company.find(:all), users(:admin).get_companies
    assert_equal [companies(:empresa)], users(:gerente_geral).get_companies
    assert_equal [companies(:empresa)], users(:admin_web).get_companies
  end

  def test_sellers
    assert users(:admin_web).sellers
    assert_equal 1,users(:admin_web).sellers.size
  end

  def test_web_administrators
    assert users(:admin_web).web_administrators
    assert users(:admin_web).web_administrators.include?(users(:admin_web))

    assert users(:gerente_geral).web_administrators
    assert users(:gerente_geral).web_administrators.include?(users(:gerente_geral))
  end

  def test_get_pendent_confirm_users_general_manager
    people = users(:gerente_geral).get_pendent_confirm_users
    assert_equal 2, people.size
    assert people.include? people(:seller_to_confirm)
    assert !people.include?(people(:seller_to_confirm_subsidiary_2))
    assert !people.include?(people(:empresa))
    assert !people.include?(people(:empresa_first_confirm))
  end

  def test_get_pendent_confirm_users_admin
    people = users(:admin).get_pendent_confirm_users
    assert_equal 3, people.size
    
  end

  def test_get_pendent_confirm_companies_general_manager
    companies = users(:gerente_geral).get_pendent_confirm_companies
    assert_equal 1, companies.size
    assert companies.include?(companies(:empresa))
    assert !companies.include?(companies(:empresa_first_confirm))
  end

  def test_get_pendent_confirm_companies_admin_web
    companies = users(:admin_web).get_pendent_confirm_companies
    assert_equal 1, companies.size
    assert companies.include?(companies(:empresa))
  end

  def test_should_not_destroy_user_with_titles
    assert !companies(:empresa_valid).titles_shipped.empty?
    assert_difference("User.count", 0) do
      users(:empresa_valid).destroy
    end
  end

  protected
  def create_user(options = {})
    record = User.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
    record.save
    record
  end
end
