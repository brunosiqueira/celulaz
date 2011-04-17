class Financial::ShippingsController < ApplicationController
  # GET /financial_shippings
  # GET /financial_shippings.xml
  layout "new_admin"

  after_filter :delete_all_titles, :only=>:update
  before_filter :login_as_director_required,:only=>:generate_shipping_file

  def index
    @shippings = Shipping.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shippings }
    end
  end

  def download
     @shipping = Shipping.find(params[:id])
     send_data(@shipping.file_data,
          :filename => @shipping.file_name,
          :type => @shipping.file_content_type,
          :disposition => "downloaded" )
  end

  # GET /financial_shippings/1
  # GET /financial_shippings/1.xml
  def show
    @shipping = Shipping.find(params[:id])
    @titles = @shipping.titles

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shipping }
    end
  end

  # GET /financial_shippings/new
  # GET /financial_shippings/new.xml
  def new
    @shipping = Shipping.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @shipping }
    end
  end

  # GET /financial_shippings/1/edit
  def edit
    @shipping = Shipping.find(params[:id])
    @titles = Title.find_all_available
    @titles.concat @shipping.titles
  end

  # POST /financial_shippings
  # POST /financial_shippings.xml
  def create
    @shipping = Shipping.new(params[:shipping])

    respond_to do |format|
      if @shipping.save
        flash[:notice] = 'Remessa criada com sucesso.'
        format.html { redirect_to(financial_shipping_path(@shipping)) }
        format.xml  { render :xml => @shipping, :status => :created, :location => @shipping }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @shipping.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /financial_shippings/1
  # PUT /financial_shippings/1.xml
  def update
    @shipping = Shipping.find(params[:id])

    respond_to do |format|
      @titles = @shipping.titles
      if @shipping.update_attributes(params[:shipping])
        flash[:notice] = 'Remessa atualizada com sucesso'
        format.html { redirect_to(financial_shipping_path(@shipping)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shipping.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /financial_shippings/1
  # DELETE /financial_shippings/1.xml
  def destroy
    @shipping = Shipping.find(params[:id])
    @shipping.destroy

    respond_to do |format|
      format.html { redirect_to(financial_shippings_url) }
      format.xml  { head :ok }
    end
  end

  private

  def delete_all_titles
    if (params[:shipping][:title_ids]).nil?
      @shipping.shipping_titles.clear
    end
  end
end
