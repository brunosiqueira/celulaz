# To change this template, choose Tools | Templates
# and open the template in the editor.

module SearchModule
  def index
    page = params[:page] || 1
    @order = params[:order] || "layout_name ASC"
    @search =  I18n.t("company.search").eql?(params[:search]) ? "" : params[:search]
    @segment_id = params[:segment_id] || "Todos"
    @companies = []
    unless "Todos" == @segment_id || @segment_id.empty?
      @companies = Company.search(@search,:per_page=>15,:page=>page, :include=>:layout,:conditions=>{:segment_id=>@segment_id}, :order=>@order)
    else
      @companies = Company.search(@search,:per_page=>15,:include=>:layout, :page=>page, :order=>@order)
    end
  end
end
