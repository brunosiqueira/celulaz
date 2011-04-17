class VisitSchedulerController < ApplicationController
  skip_before_filter :login_required

  layout "main"

  def new
    @visit_schedule = VisitSchedule.new
  end

  def create
    @visit_schedule = VisitSchedule.new params[:visit_schedule]
    if @visit_schedule.valid?
      subsidiary = Subsidiary.find @visit_schedule.subsidiary_id
      segment = Segment.find @visit_schedule.segment_id

      VisitSchedulerMailer.deliver_scheduler(@visit_schedule.name,@visit_schedule.email,@visit_schedule.ddd,
        @visit_schedule.phone,@visit_schedule.address,@visit_schedule.city,subsidiary.title,segment.name,
        @visit_schedule.time_to_visit,@visit_schedule.description)
      flash[:notice] = "Sua mensagem foi encaminhada. Aguarde que um de nossos profissionais entrará em contato com você."
      redirect_to login_path
    else
      render :action=>"new"
    end
  end

end
