module Company::ProfileHelper
  def img_tag(company)
    image_tag(company.layout.card1.url(:small), :width=>"63")
  end
end
