class Financial::MainController < ApplicationController
  before_filter :login_as_director_required

  layout "new_admin"

  def index
  end

  def generate_new_titles
    count = 0
    Contract.find_all_and_no_title(params[:month]).each { |contract|
      if (contract.parcel > contract.titles.count)
        contract.titles.create!(:due_date=> Time.utc(params[:month].to_i < 12 ? Time.now.year : Time.now.year.next,params[:month].to_i  < 12 ? params[:month].to_i.next  : 1,contract.initial_date.day),
          :value=> contract.value,
          :fine_percent=> 2,
          :days_to_charge_fine=> 0,
          :discount_type=> "Sem desconto",
          :your_number=> contract.company.drawee_code,
          :company=>contract.company,
          :emission_date=>Time.now,
          :interest_type=>"0",
          :interest_percent=>0.20,
          :additional_data=>"#{I18n.t "company.site_title"} - serviços de internet\nApós vencimento, cobrar multa de 2%\nJuros ao dia: R$ 0,50 após o vencimento")
        count+=1
      end
    }
    flash[:notice] ="#{count} títulos foram criados"
    render :action=>"index"
  end

end
