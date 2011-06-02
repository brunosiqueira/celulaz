class MainController < ApplicationController
  include LoadMap
  skip_before_filter :login_required
  before_filter :redirect_if_logged, :clean
  
  layout "main"

  def index
  end

  def who
  end

  def company
  end

  def advantages
  end

  def location
    @map = get_map("Rua Garibaldi 800 Bom Fim Porto Alegre - RS Brasil","map_agencia")
    @map_agencia_garibaldi = get_map("Rua Garibaldi 800 Bom Fim Porto Alegre - RS Brasil","map_garibaldi")
    @map_agencia = get_map("Av.Cristovão Colombo, 545, Shopping Total, loja 1261, Floresta, Porto Alegre RS Brasil")
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
