require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
#  def test_create_company_z_success
#    company = CompanyZ.new(:cnpj=>'76.633.274/0001-80',:payment_type=>"mensal",:value=>50.0,:razao_social=>'MyString',:segment=>segments(:alimentacao))
#    assert company.save
#    assert !company.contracts.empty?
#    contract = company.contracts.first
#    assert_equal contract.initial_date,company.created_at.to_date
#    assert_equal contract.end_date,(company.created_at + 1.year)
#    assert_equal contract.payment_type,company.payment_type.capitalize
#    assert company.layout
#  end

  def test_create_company_s_success
    company = CompanyS.new(:cnpj=>'76.633.274/0001-80',:razao_social=>'MyString',:segment=>segments(:alimentacao))
    assert company.save
    assert company.contracts.empty?
    assert company.layout
  end

  def test_friends
    assert_equal 1,companies(:empresa_valid).friends.size
    assert_equal [companies(:empresa_valid_2)], companies(:empresa_valid).friends
  end

  def test_friends_pendents
    assert_equal 1,companies(:empresa_valid).pendents.size
    assert_equal [companies(:empresa)], companies(:empresa_valid).pendents
  end

  def test_titles_not_payed
    assert_equal 5,companies(:empresa_valid).titles_not_payed.count
  end

  def test_paginate_no_contracts
    comps = CompanyZ.paginate_no_contracts(1)
#    assert !comps.include?(companies(:empresa_valid_2))
    assert_equal 1, comps.size
  end

  def test_has_address
    assert_not_nil companies(:empresa).address_business_card
    assert_not_nil companies(:empresa_valid).address_business_card
  end

end
