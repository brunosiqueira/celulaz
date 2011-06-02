# == Schema Information
# Schema version: 20110416172335
#
# Table name: shippings
#
#  id                :integer(4)      not null, primary key
#  code              :string(255)
#  status            :string(10)      default("Aberto")
#  created_at        :datetime
#  updated_at        :datetime
#  processing_date   :date
#  file_name         :string(255)
#  file_content_type :string(255)
#  file_data         :binary
#

class Shipping < ActiveRecord::Base
  STATUS_LIST = ["Aberto","Enviado","Retornado"]
  validates_presence_of :status, :on=>:update
  validates_inclusion_of :status,:in=>STATUS_LIST, :allow_nil=>true
  validates_uniqueness_of :processing_date,:allow_nil=>true
  validates_uniqueness_of :code
  validate_on_update :status_aberto
  before_destroy :update_before_destroy

  has_many :shipping_titles,:dependent=>:destroy
  has_many :titles,:through=>:shipping_titles

  has_many :titles_not_payed,:through=>:shipping_titles,:source=>:title,:conditions=>"titles.status<>\'#{Title::STATUS_LIQUIDADO}\'"
  has_many :titles_payed,:through=>:shipping_titles,:source=>:title,:conditions=>{:status=>Title::STATUS_LIQUIDADO}

  attr_accessor :title_ids
  after_save :update_titles

  def open?
    self.status == "Aberto"
  end

 

  def read_return_file
    read_detail ""
  end

  def total_value
    titles.sum(:value)
  end

  def total_value
    value = 0.0
    self.titles.each { |title| value+=title.value  }
    value
  end

  def file=(picture_field)
    self.file_name         = base_part_of(picture_field.original_filename)
    self.file_content_type = picture_field.content_type.chomp
    self.file_data         = picture_field.read
  end

  def base_part_of(file_name)
    File.basename(file_name).gsub(/[^\w._-]/, '' )
  end


  private

  def update_titles
    unless title_ids.nil?
      self.shipping_titles.each do |st|
        st.destroy unless title_ids.include?(st.title_id.to_s)
        title_ids.delete(st.title_id.to_s)
      end
      title_ids.each do |t|
        self.shipping_titles.create(:title_id => t) unless t.blank?
      end
      reload
      self.title_ids = nil
    end
  end

  def status_aberto
    if !"Aberto".eql?(self.status)
      errors.add_to_base(:status_should_be_aberto)
      return false
    end
    return true
  end


  def update_before_destroy
    if self.titles.count(:conditions=>"our_number is not null") == 0
      self.titles.each { |title| title.update_attribute(:status,Title::STATUS_DIGITADO) }
    elsif !"Aberto".eql?(self.status)
      errors.add_to_base(:status_should_be_aberto)
      return false
    end
    return true
  end

end
