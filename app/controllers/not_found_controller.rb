class NotFoundController < ApplicationController
  skip_before_filter :login_required
  layout nil
  def index
  end

end
