require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  def test_polymorphic
    assert !components(:gallery).pictures.empty?
  end

  def test_update
    pictures(:one).title = "ola"
    assert pictures(:one).save
    assert_equal "/images/perfil/logo_default.jpg", pictures(:one).photo_original
    assert_equal "/images/perfil/logo_default.jpg", pictures(:one).photo_big
    assert_nil pictures(:one).photo_big_dimension
  end
end
