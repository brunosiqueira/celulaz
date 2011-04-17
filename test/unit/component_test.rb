require 'test_helper'

class ComponentTest < ActiveSupport::TestCase

  def test_update_picture
    components(:picture_2).title = "ola"
    assert components(:picture_2).save
    assert_equal "/images/perfil/logo_default.jpg", components(:picture_2).picture_original
    assert_equal "/images/perfil/logo_default.jpg", components(:picture_2).picture_big
    assert_nil components(:picture_2).picture_big_dimension
  end

  def test_json
    json = components(:picture_2).to_json
    assert_match("images/perfil/logo_default.jpg", json)
    assert_match("picture_big", json)
  end

  def test_parse_fonts_colors
    comp = components(:four)
    comp.description = " bruno sqiueira COLOR=\"#000000\" oiasjdosadijoasidjasoij COLOR=\"#333333\"    COLOR=\"#00000a\"   "
    comp.save
    layout = comp.layout
    assert_equal "0x00000a;0x333333", layout.font_colors
  end

  def test_create_gallery
    assert_difference("Picture.count") do
      ComponentGallery.create! :layout=>layouts(:empresa_valid_2), :image_attachment=>File.new("test/resources/images/rails.png")
    end
  end

  def test_feed create
    assert_difference("FeedItems.count", 1) do
      assert components(:picture_2).save
    end
    assert_difference("FeedItems.count", 0) do
      assert components(:picture_2).save
    end
  end
end
