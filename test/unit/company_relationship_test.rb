require 'test_helper'

class CompanyRelationshipTest < ActiveSupport::TestCase
  def test_can_create
    companies(:empresa_valid).destinies << companies(:empresa)
    assert companies(:empresa_valid).save
    assert_equal companies(:empresa_valid).destinies.first, companies(:empresa)
  end

  def test_create_self_relationship
    new_relationship = companies(:empresa_valid).destinies_relationships.create(:destiny=>companies(:empresa_valid))
    assert  !new_relationship.valid?
    assert_equal "Um usuário não pode se relacionar consigo mesmo.",new_relationship.errors.on(:base)
  end
end
