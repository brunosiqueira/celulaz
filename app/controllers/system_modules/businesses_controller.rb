class SystemModules::BusinessesController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  before_filter :verify_contract, :except => [:business_contract]
  before_filter :unread_messages
  layout "company"

  # GET /businesses
  # GET /businesses.xml
  
  def index
    @businesses = Business.all.paginate :per_page => 2, :page => params[:page] || 1
    respond_to do |format|
      format.html
    end
  end
  
  def mine
    @businesses = current_company.company.businesses.paginate :per_page => 2, :page => params[:page] || 1
    respond_to do |format|
      format.html
    end
  end
  
  def how
    
  end

  # GET /businesses/1
  # GET /businesses/1.xml
  def show
    @business = @company.businesses.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @business }
    end
  end

  # GET /businesses/new
  # GET /businesses/new.xml
  def new
    @business = Business.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @business }
    end
  end

  # GET /businesses/1/edit
  def edit
    @business = @company.businesses.find(params[:id])
  end

  # POST /businesses
  # POST /businesses.xml
  def create
    @business = @company.businesses.build(params[:business])
    respond_to do |format|
      if @business.save
        format.html { redirect_to(company_business_path(@business), :notice => 'O Negócio foi criado com sucesso.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /businesses/1
  # PUT /businesses/1.xml
  def update
    @business = @company.businesses.find(params[:id])

    respond_to do |format|
      if @business.update_attributes(params[:business])
        format.html { redirect_to(company_business_path(@business), :notice => 'Business was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @business.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/1
  # DELETE /businesses/1.xml
  def destroy
    @business = @company.businesses.find(params[:id])
    @business.destroy

    respond_to do |format|
      format.html { redirect_to(company_businesses_url) }
      format.xml  { head :ok }
    end
  end

  def buy
    @business = Business.find params[:id]
    @company.businesses_bought << @business
    render :text=>"true"
  end
  
  def business_contract
    if request.post?
      @user = User.find(current_user)
      if @user.update_attributes(params[:user])
        redirect_to system_modules_businesses_path
      end
    end
  end
  
  private

  def verify_contract
      redirect_to :action => :business_contract unless current_company.accepted_business_contract?
  end
  
end
