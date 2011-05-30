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

class UserCompany <User
  validate :multiple_domains
  validate :domain_not_start_www
  def before_destroy
    unless self.company.titles.empty?
      self.errors.add_to_base :company_with_titles
      return false
    end
  end

  def need_subsidiary?
    !self.self_created
  end

  def subusers
    super - [UserCompany.name]
  end
  
  def find_by_subsidiary(subsidiary)
    UserCompany.find(:all,:joins=>" as users inner join people as p on users.id = p.user_id ",
      :conditions=>["p.subsidiary_id = ?",subsidiary.id])
  end

  def is_comercial?
    false
  end

  def name
    name = self.company.name
    return name
  end

  private
  def domain_not_start_www
    if (!domain.nil? && domain.start_with?("www."))
      errors.add :domain, :invalid
    end
  end
  
  def multiple_domains
    if !domain.nil?
      if !domain.match(";").nil?
        for d in domain.split(";")
          if d.match(/^([a-z0-9A-Z_\-]+)[.][a-z0-9A-Z_\-]+([.][a-z0-9A-Z_\-]+){0,1}$/)[0] != d
            errors.add :domain, :invalid
          end
        end
      else
        if domain.match(/^([a-z0-9A-Z_\-]+)[.][a-z0-9A-Z_\-]+([.][a-z0-9A-Z_\-]+){0,1}$/).nil?
          errors.add :domain, :invalid
        end
      end
    end
  end
end
