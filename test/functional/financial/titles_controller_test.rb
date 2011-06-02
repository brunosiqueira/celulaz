require 'test_helper'

class Financial::TitlesControllerTest < ActionController::TestCase
  def setup
    login_as :admin
  end
  
  test "should get index" do
    get :index,:company_id=>companies(:empresa_valid)
    assert_response :success
    assert_not_nil assigns(:titles)
  end

  test "should get index new" do
    get :index_new
    assert_response :success
    assert_not_nil assigns(:companies)
  end

  test "should get new" do
    get :new,:company_id=>companies(:empresa_valid)
    assert_response :success
    assert_equal assigns(:title).your_number,companies(:empresa_valid).drawee_code
  end

  test "should create title" do
    assert_difference('Title.count') do
      post :create,:company_id=>companies(:empresa_valid), :title => {:contract_id=>contracts(:one),:due_date=>"2009-05-05",:value=>450.00,:emission_date=>"2009-05-01",:discount_type=>"Sem desconto",:your_number=>companies(:empresa_valid).drawee_code }
    end
    assert_redirected_to financial_company_title_path(:id=>assigns(:title),:company_id=>companies(:empresa_valid))
  end

  test "should create title 2" do
    assert_difference('Title.count') do
      post :create,:company_id=>companies(:empresa_valid), :title => {"fine_percent"=>"33,33", :due_date=>"2009-05-05","your_number"=>"AZ924330",
        "abatement_value"=>"", "discount_type"=>"Sem desconto", "interest_type"=>"0", "value"=>"323,33",:emission_date=>"2009-05-01",
        "interest_percent"=>"0,50", "additional_data"=>"cdcscscsscdssd", "discount_value"=>"",  :contract_id=>contracts(:one)}
    end
    assigns(:title).reload
    assert_equal 0.50,assigns(:title).interest_percent
    assert_redirected_to financial_company_title_path(:id=>assigns(:title),:company_id=>companies(:empresa_valid))
  end

  test "should show title" do
    get :show,:company_id=>companies(:empresa_valid), :id => titles(:one)
    assert_response :success
  end


  test "should get edit" do
    get :edit,:company_id=>companies(:empresa_valid), :id => titles(:one)
    assert_response :success
  end

  test "should update title" do
    put :update, :id => titles(:one), :title => { },:company_id=>companies(:empresa_valid)
    assert_redirected_to financial_company_title_url(:id=>assigns(:title),:company_id=>companies(:empresa_valid))
  end

  test "should destroy title" do
    assert_difference('Title.count', -1) do
      delete :destroy, :id => titles(:one),:company_id=>companies(:empresa_valid)
    end

    assert_redirected_to financial_company_titles_path
  end
end
