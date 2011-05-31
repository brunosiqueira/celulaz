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

class UserGeneralManager < UserSupport
  def subusers
    super - [UserGeneralManager.name]
  end
  
  def get_subusers_companies(page=1)
    page||=1
    UserCompany.paginate :page=>page, :include=>[:company,:person],
      :order=>"companies.razao_social",
      :conditions=>["people.subsidiary_id = :subsidiary ",
      {:subsidiary=>self.subsidiary.id}]
  end

  def get_subusers_non_companies(page=1)
    page||=1
    user_types = subusers - [UserCompany.name]
    User.paginate :page=>page, 
      :include=>:person,
      :conditions=>["people.subsidiary_id = :subsidiary and users.type in (:types)",
      {:subsidiary=>self.subsidiary.id,:types=>user_types}], :order=>"login"
  end
  
  def get_pendent_confirm_users(page=1)
    page||=1
    user_types = subusers - [UserCompany.name]
    self.people(false,user_types,page)
  end

  def get_pendent_confirm_companies(page=1)
    page||=1
    Company.paginate(:page=>page,
      :joins=>" as companies join user_people as up on companies.user_id = up.user_id join people as people on people.id = up.person_id",
      :order=>"razao_social",
      :conditions=>["people.user_confirm_id is null and people.subsidiary_id= :subsidiary_id",
        {:subsidiary_id=>self.subsidiary.id}])
    
  end
  
  def get_companies
    Company.find(:all,:joins=>" as companies join user_people as up on companies.user_id = up.user_id join people as people on people.id = up.person_id",
      :conditions=>["people.subsidiary_id = :subsidiary",
        {:subsidiary=>self.subsidiary.id}],:order=>"companies.razao_social")
  end

  def paginate_companies(page,segment_id=nil)
    if segment_id.nil?
      Company.paginate(:page=>page,:include => [:user, :segment, :seller],:joins=>" as companies join user_people as up on companies.user_id = up.user_id join people as people on people.id = up.person_id",
        :conditions=>["people.subsidiary_id = :subsidiary",
          {:subsidiary=>self.subsidiary.id}],:order=>"companies.razao_social")
    else
      Company.paginate(:page=>page,:include => [:user, :segment, :seller],:joins=>" as companies join user_people as up on companies.user_id = up.user_id join people as people on people.id = up.person_id",
        :conditions=>["people.subsidiary_id = :subsidiary and companies.segment_id=:segment_id",
          {:subsidiary=>self.subsidiary.id,:segment_id=>segment_id}],:order=>"companies.razao_social")
    end
  end

  def owns_company?(company)
    Company.count(:id,:joins=>" as companies join user_people as up on companies.user_id = up.user_id join people as people on people.id = up.person_id",
      :conditions=>["people.subsidiary_id = :subsidiary and companies.id=:id",
        {:subsidiary=>self.subsidiary.id,:id=>company.id}],:order=>"companies.razao_social")>0
  end

  def need_subsidiary?
    true
  end
  
  
  def people(confirmed=true,user_types=[],page=1,paginate=true)
    page||=1
    user_types = subusers - [UserCompany.name] if user_types.empty?
    query = "select people.* from people as people "
    query << "where people.user_confirm_id is #{confirmed ? "not" : ""} null "
    query << "and people.subsidiary_id= :subsidiary_id "
    query << "and not exists (select up.* from user_people as up where people.id = up.person_id) "
    query << "union "
    query << "select people.* from people as people "
    query << "inner join user_people as up on people.id = up.person_id "
    query << "inner join users as u on up.user_id = u.id "
    query << "and u.type in (:types) "
    query << "where people.user_confirm_id is #{confirmed ? "not" : ""} null "
    query << "and people.subsidiary_id= :subsidiary_id "
    query << "and u.id<>:id "
    query << "order by name "
    if paginate
      return Person.paginate_by_sql [query,{:subsidiary_id=>self.subsidiary.id,:id=>self.id,:types=>user_types}],:page=>page
    else
      return Person.find_by_sql [query,{:subsidiary_id=>self.subsidiary.id,:id=>self.id,:types=>user_types}]
    end
  end

  def web_administrators
    user_types = subusers - [UserCompany.name]
    users = User.find(:all,:include=>:person,
      :order=>"login",
      :conditions=>['type in (:types) and people.subsidiary_id=:subsidiary_id',{:types=>user_types,:subsidiary_id=>self.subsidiary.id}])
    users << self
  end

  def subsidiaries
    person.subsidiary ? [person.subsidiary] : []
  end


  def confirm(people)
    if people.user_create.nil?
      people.user_create = self
    else
      people.user_confirm = self
    end
  end

  
end
