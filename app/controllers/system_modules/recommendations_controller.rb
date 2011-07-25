class SystemModules::RecommendationsController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  
  def create
    Recommendation.delay.deliver_sendrecommendation(params[:addresses], current_company.company)
    render :text => "ok"
  end

end
