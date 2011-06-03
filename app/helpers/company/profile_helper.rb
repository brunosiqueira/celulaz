module Company::ProfileHelper
  def img_tag(company)
    image_tag(company.layout.card1.url(:small), :width=>"63")
  end

  def can_buy(business)
    if current_company.company.businesses.include?(business)
      return false
    elsif !business.can_buy?(current_company.company)
      return false
    end
    return true
  end
end
