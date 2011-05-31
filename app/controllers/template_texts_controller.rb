class TemplateTextsController < ApplicationController
  # GET /template_texts
  # GET /template_texts.xml
  before_filter :login_required
  layout "new_admin"
  def index
    @template_texts = TemplateText.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @template_texts }
    end
  end

  # GET /template_texts/1
  # GET /template_texts/1.xml
  def show
    @template_text = TemplateText.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @template_text }
      format.js{render :text=>@template_text.content}
    end
  end

  # GET /template_texts/new
  # GET /template_texts/new.xml
  def new
    @template_text = TemplateText.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @template_text }
    end
  end

  # GET /template_texts/1/edit
  def edit
    @template_text = TemplateText.find(params[:id])
  end

  # POST /template_texts
  # POST /template_texts.xml
  def create
    @template_text = TemplateText.new(params[:template_text])

    respond_to do |format|
      if @template_text.save
        format.html { redirect_to(@template_text, :notice => 'Texto criado com sucesso.') }
        format.xml  { render :xml => @template_text, :status => :created, :location => @template_text }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @template_text.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /template_texts/1
  # PUT /template_texts/1.xml
  def update
    @template_text = TemplateText.find(params[:id])

    respond_to do |format|
      if @template_text.update_attributes(params[:template_text])
        format.html { redirect_to(@template_text, :notice => 'Texto atualizado com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @template_text.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /template_texts/1
  # DELETE /template_texts/1.xml
  def destroy
    @template_text = TemplateText.find(params[:id])
    @template_text.destroy

    respond_to do |format|
      format.html { redirect_to(template_texts_url) }
      format.xml  { head :ok }
    end
  end
end
