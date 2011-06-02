# == Schema Information
# Schema version: 20110416172335
#
# Table name: contracts
#
#  id           :integer(4)      not null, primary key
#  company_id   :integer(4)
#  initial_date :date
#  end_date     :date
#  status       :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  value        :float
#  parcel       :integer(4)
#

class Contract < ActiveRecord::Base
  STATUS_LIST = ["Aberto","Fechado"]
  belongs_to :company
  has_many :titles, :order=>"emission_date desc",:dependent => :destroy
  has_many :titles_shipped,:class_name=>"Title",:dependent => :destroy,:conditions=>["status <> ? ","Digitado"], :order=>"emission_date desc"
  has_many :titles_not_payed,:class_name=>"Title",:conditions=>"titles.status<>\'#{Title::STATUS_LIQUIDADO}\'",:dependent => :destroy
  has_many :titles_payed,:class_name=>"Title",:conditions=>{:status=>Title::STATUS_LIQUIDADO},:dependent => :destroy

  validates_presence_of :company, :initial_date, :end_date,:parcel, :value
  validates_inclusion_of :status,:in=>STATUS_LIST

  before_validation :initial_status
  
  def Contract.status_list
    STATUS_LIST
  end

  #Recupera os contratos em aberto que não possuem títulos emitidos no mês corrente.
  def Contract.find_all_and_no_title(month)
    date = Time.utc Time.now.year,month,1
    Contract.find :all, :include=>:company,
      :conditions=>["status=? and not exists (select 1 from titles where contracts.id = titles.contract_id and titles.emission_date >= ?) and companies.type = ? and initial_date<=? and end_date>=?",
      "Aberto",date,CompanyZ.name,Time.now,Time.now]
  end 

  private
  def initial_status
    self.status||="Aberto"
  end
end
