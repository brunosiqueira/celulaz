# == Schema Information
# Schema version: 20110416172335
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

class UserWebAdministrator <UserSegmentManager
  def subusers
    super - [UserWebAdministrator.name]
  end

  def people(confirmed=true,user_types=[],page=1,paginate=true)
    page||=1
    if paginate
      self.sellers.paginate :page=>page, :include => [:subsidiary, :web_adm],:conditions=>["user_confirm_id is #{confirmed ? "not" : ""} null"],:order=>"name"
    else
      self.sellers.find :all, :include => [:subsidiary, :web_adm],:conditions=>["user_confirm_id is #{confirmed ? "not" : ""} null"],:order=>"name"
    end
  end 

  def confirm(people)
    super(people)
    people.web_adm = self
  end

  def get_companies
    Company.find(:all,
      :joins=>" as companies join user_people as up on companies.user_id = up.user_id join people as people on people.id = up.person_id",
      :conditions=>["people.user_web_adm_id = ?",
        self.id],:order=>"companies.razao_social")
  end

  def paginate_companies(page,segment_id=nil)
    if segment_id.nil?
      Company.paginate(:page=>page,:include => [:user, :segment, :seller],
        :joins=>" as companies join user_people as up on companies.user_id = up.user_id join people as people on people.id = up.person_id",
        :conditions=>["people.user_web_adm_id = ?",
          self.id],:order=>"companies.razao_social")
    else
      Company.paginate(:page=>page,:include => [:user, :segment, :seller],
        :joins=>" as companies join user_people as up on companies.user_id = up.user_id join people as people on people.id = up.person_id",
        :conditions=>["people.user_web_adm_id = ? and companies.segment_id=?",
          self.id,segment_id],:order=>"companies.razao_social")
    end

  end

  def owns_company?(company)
    Company.count(:id,:joins=>"as companies join user_people as up on companies.user_id = up.user_id join people as people on people.id = up.person_id",
      :conditions=>["people.user_web_adm_id = ? and companies.id=?",
        self.id,company.id],:order=>"companies.razao_social")>0
  end

  def get_subusers_companies(page=1)
    page||=1
    UserCompany.paginate :page=>page,
      :include=>[:company,:person],
      :conditions=>["people.subsidiary_id = ? AND people.user_web_adm_id = ?",
      self.subsidiary.id,self.id], :order=>"companies.razao_social"
  end

  def get_pendent_confirm_companies(page=1)
    page||=1
    Company.paginate :page=>page,
      :joins=>" as companies join user_people as up on companies.user_id = up.user_id join people as people on people.id = up.person_id",
      :conditions=>["people.user_confirm_id is null and people.subsidiary_id= :subsidiary_id and people.user_web_adm_id = :id",
      {:subsidiary_id=>self.subsidiary.id,:id=>self.id}],
      :order=>"razao_social"


  end
end
