class SystemModules::TestimonialsController < ApplicationController
  before_filter :login_with_company_required
  before_filter :load_company
  
  def create
    @testimonial = Testimonial.new(params[:testimonial])
    
    respond_to do |format|
      if @testimonial.save
        format.js{render :text=> "Mensagem enviada com sucesso." }
      else
        format.js{render :text=> "Ocorreu um erro no envio da mensagem." }
      end
    end
  end
  
  def update
    @testimonial = Testimonial.find(params[:id])
    @testimonial.approved = true
    if @testimonial.save
      render :text => "ok"
    end
  end
  
  def destroy
    @testimonial = Testimonial.find(params[:id])
    @testimonial.approved = true
    if @testimonial.destroy
      render :text => "ok"
    end
  end

end
