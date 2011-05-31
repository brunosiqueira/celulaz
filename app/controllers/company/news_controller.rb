class Company::NewsController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  layout nil

  def create
    @company.news.create(:description=>params[:value])
    render :text=>Time.now.to_s_br
  end
end
