class Financial::TitlesController < ApplicationController
  before_filter :login_as_financial_user_required
  layout "new_admin"

  before_filter :find_company,:except=>["index","index_new"]

  def index
    page = params[:page] || 1
    @titles = Title.paginate :page=>page,:include => [:company], :order=>"due_date desc"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @titles }
    end
  end

  def index_new
    page = params[:page] || 1
    @companies = CompanyZ.paginate :page=>page, :order=>"razao_social"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @companies }
    end
  end

  # GET /titles/1
  # GET /titles/1.xml
  def show
    @title = @company.titles.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @title }
    end
  end

  # GET /titles/new
  # GET /titles/new.xml
  def new
    @title = Title.new :your_number => @company.drawee_code
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @title }
    end
  end

  # GET /titles/1/edit
  def edit
    @title = @company.titles.find(params[:id])
  end

  # POST /titles
  # POST /titles.xml
  def create
    fix_decimal_numbers(params[:title])
    @title = Title.new(params[:title])

    respond_to do |format|
      if @company.titles << @title
        flash[:notice] = 'Título foi criado com sucesso.'
        format.html { redirect_to(financial_company_title_url(:id=>@title,:company_id=>@company)) }
        format.xml  { render :xml => @title, :status => :created, :location => @title }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @title.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /titles/1
  # PUT /titles/1.xml
  def update
    @title = @company.titles.find(params[:id])

    fix_decimal_numbers(params[:title])
    respond_to do |format|
      if @title.update_attributes(params[:title])
        flash[:notice] = 'Título foi atualizado com sucesso.'
        format.html { redirect_to(financial_company_title_url(:id=>@title,:company_id=>@company)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @title.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /titles/1
  # DELETE /titles/1.xml
  def destroy
    @title = @company.titles.find(params[:id])
    Title.destroy(@title)

    respond_to do |format|
      format.html { redirect_to(financial_company_titles_url(@company)) }
      format.xml  { head :ok }
    end
  end

 

  private

  def find_company
    @company_id = params[:company_id]
    unless @company_id
      flash[:notice]=I18n.t "company.messages.not_found"
      return(redirect_to(:controller=>"/company_management"))
    end
    @company = Company.find(@company_id)
    flash[:notice] = "Para criar um título, cadastre primeiro um contrato novo." if @company.open_contracts.empty?
  end

  def fix_decimal_numbers(title_hash)
    unless title_hash[:fine_percent].nil?
      title_hash[:fine_percent].gsub!(".","")
      title_hash[:fine_percent].gsub!(",",".")
    end
    unless title_hash[:interest_percent].nil?
      title_hash[:interest_percent].gsub!(".","")
      title_hash[:interest_percent].gsub!(",",".")
    end
  end
end
