class Company::RelationshipRequestController < ApplicationController
  layout nil
  def new
    @company = Company.find params[:id]
  end
  
  def create
    company = Company.find params[:id]
    current = current_company.company
    if current.has_origins? company
      redirect_to :action=>:update,:id=>company.id
    elsif current.has_destinies? company
      flash[:notice] = I18n.t 'company.messages.relationship_initialized'
      respond_to do |format|
        format.js
      end
    else
      company_relationship = CompanyRelationship.create!(:origin=>current,:destiny=>company)
      CompanyRelationshipMailer.delay.deliver_request(company_relationship,params[:observation])
      flash[:notice] = 'Relacionamento iniciado. Aguarde confirmação'
      respond_to do |format|
        format.js
      end
    end
  rescue
    flash[:error] = I18n.t "company.messages.relationship_unable"
    respond_to do |format|
      format.js
    end
  end

  def update
    current = current_company.company
    relationship = current.origins_relationships.find_by_company_origin_id(params[:id])
    relationship.confirm!
    unless relationship.save
      flash[:error] = 'Não foi possível confirmar o relacionamento.'
    else
      flash[:notice] = 'Relacionamento criado com sucesso.'
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    current = current_company.company
    company = Company.find params[:id]

    current.origins.delete(company)
    current.destinies.delete(company)
    flash[:notice] = 'Relacionamento cancelado.'
    redirect_to :controller=>"company/profile",:action=>"public",:id=>company
  end
end
