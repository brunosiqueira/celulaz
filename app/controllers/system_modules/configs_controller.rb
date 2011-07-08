class SystemModules::ConfigsController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  
  def update
    @config = Preference.find_or_create_by_user_id(params[:id])
    respond_to do |format|
      if @config.update_attributes(params[:preference])
        format.js
      end
    end
  end

end
