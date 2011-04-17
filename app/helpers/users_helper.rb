module UsersHelper

  COMPANY_COLOR = {"CompanyS"=>"yellow","CompanyZ"=>"blue"}
  def color_cell_type(clazz)
    type = COMPANY_COLOR[clazz]
    return !type.nil? ? type : "gray"
  end

end