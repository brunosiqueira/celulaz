class WhoisController < ApplicationController
  skip_before_filter :login_required
  def check
    Socket::getaddrinfo(params[:domain], 'www', nil, Socket::SOCK_STREAM)
    render :text=>true
  rescue
    render :text=>false
  end

end
