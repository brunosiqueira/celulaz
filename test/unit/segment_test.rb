require 'test_helper'

class SegmentTest < ActiveSupport::TestCase
  def test_file_path
    companies(:empresa_valid).segment.attributes[:file]
  end
end
