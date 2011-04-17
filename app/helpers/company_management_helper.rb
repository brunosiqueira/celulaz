module CompanyManagementHelper
  def self.show_seller_detailed(seller)
    seller.name + (seller.user ? " - #{ApplicationHelper.humanize_user(seller.user[:type])}" : ApplicationHelper.show_web_adm(seller))
  end
end
