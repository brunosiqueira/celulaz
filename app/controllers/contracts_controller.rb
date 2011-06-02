class ContractsController < ApplicationController
  # GET /contracts
  # GET /contracts.xml
  layout "new_admin"

  before_filter :find_company
  
  def index
    @contracts = @company.contracts
    if @contracts.empty?
      redirect_to new_company_contract_url(@company)
    else
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @contracts }
      end
    end
  end

  # GET /contracts/1
  # GET /contracts/1.xml
  def show
    @contract = @company.contracts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contract }
    end
  end

  # GET /contracts/new
  # GET /contracts/new.xml
  def new
    @contract = Contract.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contract }
    end
  end

  # GET /contracts/1/edit
  def edit
    @contract = @company.contracts.find(params[:id])
  end

  # POST /contracts
  # POST /contracts.xml
  def create
    @contract = Contract.new(params[:contract])

    respond_to do |format|
      if @company.contracts << @contract
        flash[:notice] = 'Contrato foi criado com sucesso.'
        format.html { redirect_to(company_contract_url(:id=>@contract,:company_id=>@company)) }
        format.xml  { render :xml => @contract, :status => :created, :location => @contract }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contract.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contracts/1
  # PUT /contracts/1.xml
  def update
    @contract = @company.contracts.find(params[:id])

    respond_to do |format|
      if @contract.update_attributes(params[:contract])
        flash[:notice] = 'Contrato atualizado com sucesso.'
        format.html { redirect_to(company_contract_url(:id=>@contract,:company_id=>@company)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contract.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.xml
  def destroy
    @contract = @company.contracts.find(params[:id])
    Contract.destroy @contract

    respond_to do |format|
      format.html { redirect_to(company_contracts_url(@company)) }
      format.xml  { head :ok }
    end
  end

  private

  def find_company
    @company_id = params[:company_id]
    unless @company_id
      flash[:notice]=I18n.t "company.messages.not_found"
      return(redirect_to(:controller=>:company_management))
    end
    @company = Company.find(@company_id)
  end

end
