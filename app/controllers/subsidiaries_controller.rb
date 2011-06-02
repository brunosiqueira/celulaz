class SubsidiariesController < ApplicationController
  # GET /subsidiaries
  # GET /subsidiaries.xml
  before_filter :login_as_director_required

  layout "new_admin"
  
  def index
    @subsidiaries = Subsidiary.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @subsidiaries }
    end
  end

  # GET /subsidiaries/1
  # GET /subsidiaries/1.xml
  def show
    @subsidiary = Subsidiary.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @subsidiary }
    end
  end

  # GET /subsidiaries/new
  # GET /subsidiaries/new.xml
  def new
    @subsidiary = Subsidiary.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @subsidiary }
    end
  end

  # GET /subsidiaries/1/edit
  def edit
    @subsidiary = Subsidiary.find(params[:id])
  end

  def edit_range
    @subsidiary = Subsidiary.find(params[:id])
  end

  def change_range
    @subsidiary = Subsidiary.find(params[:id])
    state = State.find(params[:state])
    if @subsidiary.states.include?(state)
      @subsidiary.states.delete(state) 
    else
      @subsidiary.states << state
    end
    @subsidiary.save
    render :action=>"edit_range"
  end

  # POST /subsidiaries
  # POST /subsidiaries.xml
  def create
    @subsidiary = Subsidiary.new(params[:subsidiary])

    respond_to do |format|
      if @subsidiary.save
        flash[:notice] = 'Filial criada com sucesso.'
        format.html { redirect_to(@subsidiary) }
        format.xml  { render :xml => @subsidiary, :status => :created, :location => @subsidiary }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @subsidiary.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /subsidiaries/1
  # PUT /subsidiaries/1.xml
  def update
    @subsidiary = Subsidiary.find(params[:id])

    respond_to do |format|
      if @subsidiary.update_attributes(params[:subsidiary])
        flash[:notice] = 'Filial atualizada com sucesso.'
        format.html { redirect_to(@subsidiary) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @subsidiary.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /subsidiaries/1
  # DELETE /subsidiaries/1.xml
  def destroy
    @subsidiary = Subsidiary.find(params[:id])
    unless @subsidiary.people.empty?
      flash[:error]="Exclusão negada. A filial possui usuários."
    else
      @subsidiary.destroy
    end
    respond_to do |format|
      format.html { redirect_to(subsidiaries_url) }
      format.xml  { head :ok }      
    end
  end

end
