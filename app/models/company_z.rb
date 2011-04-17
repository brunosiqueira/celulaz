# == Schema Information
# Schema version: 20110315144312
#
# Table name: companies
#
#  id                        :integer(4)      not null, primary key
#  user_id                   :integer(4)
#  cnpj                      :string(18)
#  razao_social              :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#  person_id                 :string(255)
#  payment_type              :string(10)      default("mensal")
#  segment_id                :string(255)
#  state_id                  :string(255)
#  type                      :string(10)      default("CompanyS"), not null
#  informal                  :boolean(1)
#  drawee_code               :string(15)
#  register_number           :string(255)
#  profile_logo_file_name    :string(255)
#  profile_logo_content_type :string(255)
#  profile_logo_file_size    :integer(4)
#  profile_logo_updated_at   :datetime
#

# To change this template, choose Tools | Templates
# and open the template in the editor.

class CompanyZ < Company
  def self.paginate_not_payed(page)
    return CompanyZ.paginate :select=>"distinct companies.* as companies ",:include => [:user, :segment], :page=>page,
      :joins =>" join titles as titles on titles.company_id = companies.id",
      :conditions=>["titles.status <> ?  and titles.due_date < ? and your_number is not null",Title::STATUS_LIQUIDADO,Time.now],
      :order=>"razao_social"
  end
  def self.paginate_no_contracts(page)
    return CompanyZ.paginate :include => [:user, :segment,:contracts], :page=>page,
      :conditions=>["not exists (select * from contracts as c where c.end_date >= ? and c.company_id = companies.id)", Time.now],
      :order=>"razao_social"
  end
end
