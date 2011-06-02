class Company::ColorsController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  after_filter :clean_cache
  layout nil
  def edit
  end

  def show
    render :text=>@layout.color.to_json
  end

  def show_template
    render :text=>ColorTemplate.find(params[:id]).to_json
  end

  def update
    @layout.color.update_attributes(params[:color]);
    render :text=>"true"
  end

end
