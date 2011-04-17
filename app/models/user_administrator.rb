# == Schema Information
# Schema version: 20110315144312
#
# Table name: users
#
#  id                        :integer(4)      not null, primary key
#  login                     :string(255)
#  email                     :string(255)
#  crypted_password          :string(40)
#  salt                      :string(40)
#  created_at                :datetime
#  updated_at                :datetime
#  remember_token            :string(255)
#  remember_token_expires_at :datetime
#  activation_code           :string(40)
#  activated_at              :datetime
#  password_reset_code       :string(40)
#  enabled                   :boolean(1)      default(TRUE)
#  type                      :string(255)
#  self_created              :boolean(1)
#  avatar_file_name          :string(255)
#  avatar_content_type       :string(255)
#  avatar_file_size          :integer(4)
#  avatar_updated_at         :datetime
#  domain                    :string(255)
#

# To change this template, choose Tools | Templates
# and open the template in the editor.

class UserAdministrator < User
  def get_companies
    Company.find(:all,:order=>"razao_social")
  end

  def paginate_companies(page, segment_id=nil)
    if segment_id.nil?
      Company.paginate(:page=>page,:include => [:user, :segment, :seller],:order=>"razao_social")
    else
      Company.paginate(:page=>page,:include => [:user, :segment, :seller],:order=>"razao_social",:conditions=>{:segment_id=>segment_id})
    end
  end

  def owns_company?(company)
    Company.count(:conditions=>{:id=>company.id})>0
  end

  def get_companies_no_contract
    companies = self.get_companies
    no_contract =[]
    companies.each { |company| no_contract << company if CompanyZ.name == company[:type] && company.open_contracts.empty?  }
    no_contract
  end


  def people(confirmed=true,user_types=[],page=1,paginate=true)
    page||=1
    if paginate
      Person.paginate :page=>page,:include => [:subsidiary, :web_adm],
        :joins=>" as people left join user_people as up on people.id = up.person_id left join users as u on up.user_id = u.id and u.type <>'#{UserCompany.name}'",
        :order=>"people.name",
        :conditions=>"user_confirm_id is #{confirmed ? "not" : ""} null "
    else
      Person.find :all,
        :joins=>" as people left join user_people as up on people.id = up.person_id left join users as u on up.user_id = u.id and u.type <>'#{UserCompany.name}'",
        :order=>"people.name",
        :conditions=>"user_confirm_id is #{confirmed ? "not" : ""} null "
    end
  end

  def subsidiaries
    Subsidiary.find :all
  end

  def web_administrators
    user_types = subusers - [UserCompany.name] - [UserAdministrator.name]
    User.find(:all,:conditions=>['type in (:types)',{:types=>user_types}])
  end

  def need_subsidiary?
    false
  end

  def name
    self.person.name
  end
  
end
