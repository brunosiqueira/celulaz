class SystemModules::BusinessesController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  before_filter :verify_contract, :except => [:business_contract]
  before_filter :unread_messages
  layout "new_layout"

  # GET /businesses
  # GET /businesses.xml
  
  def index
    @businesses = Business.paginate :per_page => 10, :page => params[:page] || 1, :order => ["updated_at DESC"], :conditions => ['status = "Publicado"']
    respond_to do |format|
      format.html
    end
  end
  
  # GET /businesses/1
  # GET /businesses/1.xml
  def show
    @business = Business.find(params[:id])
    respond_to do |format|
      if (@business.status == 'Rascunho') && @business.company != current_company.company  
        format.html { redirect_to ( {:controller => "system_modules/businesses", :action => "mine"}, :notice => 'Você não pode ver esta campanha.') }
      else
        format.html
      end
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
    @business = current_company.company.businesses.find(params[:id])
    respond_to do |format|
      if @business.status != 'Rascunho'
        format.html { redirect_to ( {:controller => "system_modules/businesses", :action => "mine"}, :notice => 'Você não pode editar esta campanha.') }
      else
        format.html
      end
    end
  end

  # POST /businesses
  # POST /businesses.xml
  def create
    @business = @company.businesses.build(params[:business])
    respond_to do |format|
      if @business.save
        format.html { redirect_to(system_modules_business_path(@business), :notice => 'Sua campanha foi criado. Bons negócios.') }
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
        format.html { redirect_to(system_modules_business_path(@business), :notice => 'A campanha foi editada corretamente.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /businesses/1
  # DELETE /businesses/1.xml
  def destroy
    @business = current_company.company.businesses.find(params[:id])
    @business.destroy
    respond_to do |format|
      format.html { redirect_to ( {:controller => "system_modules/businesses", :action => "mine"}, :notice => 'A campanha foi removida corretamente.') }
      format.xml  { head :ok }
    end
  end
  
  def business_contract
    if request.post?
      @user = User.find(current_user)
      if @user.update_attributes(params[:user])
        redirect_to system_modules_businesses_path
      end
    end
  end
  
  # mine campaigns
  def mine
    @businesses = current_company.company.businesses.paginate :per_page => 10, :page => params[:page] || 1, :order => ["updated_at DESC"]
    respond_to do |format|
      format.html
    end
  end
  
  # campaigns that an user bought
  def mine_coupons
    @campaigns = current_company.company.businesses_bought.paginate :per_page => 10, :page => params[:page] || 1, :order => ["created_at DESC"]
  end
  
  # end the campaign
  def end_campaign
    if request.post?
      @business = current_company.company.businesses.find(params[:id])
      @business.status = 'Finalizado'
      if @business.save
        respond_to do |format|
          format.html { redirect_to({:controller => "system_modules/businesses", :action => "mine"}, :notice => 'A campanha foi finalizada corretamente.')}
        end
      end
    end
  end
  
  # acquire a campain
  def purchase_campaign
    if request.post?
      @business = Business.find(params[:id])
      @voucher = @business.business_companies.build(:company_id => current_company.company.id)
      respond_to do |format|
        if @voucher.save
          format.html { redirect_to(system_modules_business_path(@business), :notice => 'O cupom foi adquirido. Parabéns!!') }
        else
          format.html { redirect_to(system_modules_business_path(@business), :notice => 'Você não pode mais adquirir este cupom.') }
        end
      end
    end
  end
  
  # to print a voucher campaign
  def print_voucher
    @business = Business.find(params[:id])
    render :layout => "voucher"
  end

  def buyers 
    @business = Business.find(params[:id])
    @companies = @business.business_companies
    render :layout => "false"
  end
  
  def verify_contract
      render :action => :business_contract if current_company.accepted_business_contract == nil || current_company.accepted_business_contract == false
  end
  
end
