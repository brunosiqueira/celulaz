class CompanyObserver < ActiveRecord::Observer
  def after_save(company)
    CompanyMailer.delay.deliver_changed_to_s(company) if company.changed_to_s?
    CompanyMailer.delay.deliver_changed_to_z(company) if company.changed_to_z?
  end
end
