class AddNewSegmentToSegment < ActiveRecord::Migration
  def self.up
    Segment.create(:name=>"Universitário")
  end

  def self.down
    Segment.delete_all(["name=?","Universitário"])
  end
end
