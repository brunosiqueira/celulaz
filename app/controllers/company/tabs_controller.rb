class Company::TabsController < ApplicationController
  before_filter :login_with_company_required
  before_filter :login_with_company_z_required
  before_filter :load_company,:except=>:new
  layout nil
  def create
    @tab = @layout.tabs.create(params[:tab])
    respond_to do |format|
      format.json{render :json=>@tab}
    end
  rescue Exception => err
    respond_to do |format|
      format.json{render(:json => {"error" => err.to_s}.to_json )}
    end
  end

  def update
    @tab = @layout.tabs.find(params[:id])
    @tab.update_attributes(params[:tab])
    respond_to do |format|
      format.json{render :json=>@tab}
    end
  rescue Exception => err
    respond_to do |format|
      format.json{render(:json => {"error" => err.to_s}.to_json )}
    end
  end

  def reorder
    order = 1
    params[:tab_ids].each { |id|
      @layout.tabs.find(id).update_attribute(:order,order)
      order = order.next
    }
        respond_to do |format|
      format.json{render :text=>"true"}
    end
  rescue Exception => err
    respond_to do |format|
      format.json{render(:json => {"error" => err.to_s}.to_json )}
    end
  end

  def destroy
    @tab = @layout.tabs.find params[:id]
    @layout.tabs.delete(@tab)
    respond_to do |format|
      format.json{render :text=>"true"}
    end
  rescue Exception => err
    respond_to do |format|
      format.json{render(:json => {"error" => err.to_s}.to_json )}
    end
  end
end
