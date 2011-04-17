class SearchController < ApplicationController
  include SearchModule
  skip_before_filter :login_required
  layout "new_business_cards"
end
