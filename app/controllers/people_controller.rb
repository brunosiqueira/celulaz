class PeopleController < ApplicationController
  # GET /people
  # GET /people.xml
  before_filter :check_comercial_user

  layout "new_admin"
  def index
    @people = current_user.people(true,[], params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @people }
    end
  end
  def find_cpf
    if @person = Person.find_by_cpf(params[:cpf])
      @different_subsidiary = current_user.need_subsidiary? && !current_user.person.subsidiary.eql?(@person.subsidiary)
      respond_to do |format|
        format.js
      end
    else
      @person = Person.new
      render :text=>"true"
    end
  end

  # GET /people/1
  # GET /people/1.xml
  def show
    @person = Person.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @person }
    end
  end

  # GET /people/new
  # GET /people/new.xml
  def new
    @person = Person.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @person }
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
  end

  # POST /people
  # POST /people.xml
  def create
    @person = Person.new(params[:person])
    current_user.confirm(@person)

    #Atribui a filial do  usuário corrente, caso o mesmo não seja administrador ou diretor
    @person.subsidiary = current_user.person.subsidiary if logged_in? && !current_user.is_director? && !current_user.is_administrator?

    respond_to do |format|
      if @person.save
        flash[:notice] = 'Pessoa criada com sucesso!'
        format.html { redirect_to(@person) }
        format.xml  { render :xml => @person, :status => :created, :location => @person }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.xml
  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        flash[:notice] = 'Pessoa atualizada com sucesso!'
        format.html { redirect_to(@person) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /people/1
  # DELETE /people/1.xml
  def destroy
    @person = Person.find(params[:id])
    @person.destroy if @person.users.empty?
  
    respond_to do |format|
      format.html { redirect_to(people_url) }
      format.xml  { head :ok }
    end
  end
  


end
