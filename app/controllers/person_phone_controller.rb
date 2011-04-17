class PersonPhoneController < ApplicationController
  def create
    @person = Person.find params[:id]
    @phone = Phone.new params[:phone]
    @phone.person = @person
    render :update do |page|
      if @phone.save
        page.insert_html(:bottom,"telefones",:partial=>"person_phone/phone",:object=>@phone)
      else
        page.alert(@phone.errors.each_full{|msg|"\n"+ msg  })
      end
    end
  end

  def destroy
    Phone.destroy(params[:id])
    render :update do |page|
      page.visual_effect :fade, "phone_#{params[:id]}",:duration=>0.5
    end
  end

end
