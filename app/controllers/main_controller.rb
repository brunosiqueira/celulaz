class MainController < ApplicationController
  include LoadMap
  skip_before_filter :login_required
  before_filter :redirect_if_logged, :clean
  
  layout "main"

  def index
  end

  def who
  end

  def advantages
  end

  def natal
  end
  
  private
  def redirect_if_logged
    redirect_to_user_role if current_user
  end

  def clean
    expire_action :action => :index
  end
end
