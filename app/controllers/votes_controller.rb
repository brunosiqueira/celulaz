class VotesController < ApplicationController
  def new
    @company = Company.find params[:id]
  end

  def create
    @company = Company.find params[:id]
    current_company.send(params[:vote_type],@company)
    render :update do |page|
      page << "RedBox.close();"
    end
  end

end
