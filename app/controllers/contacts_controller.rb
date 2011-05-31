class ContactsController < ApplicationController
 skip_before_filter :login_required

  layout "main"

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new params[:contact]
    if @contact.valid?
      ContactMailer.delay.deliver_contact_us(@contact)
      flash[:notice] = "Sua mensagem foi encaminhada. Aguarde que um de nossos profissionais entrará em contato com você."
      if RAILS_ENV == "production"
          flash[:notice] << '<!-- Google Code for Contato no Fale conosco Conversion Page -->
            <script type="text/javascript">
            /* <![CDATA[ */
            var google_conversion_id = 989805764;
            var google_conversion_language = "pt";
            var google_conversion_format = "2";
            var google_conversion_color = "ffffff";
            var google_conversion_label = "1pFvCMypoAIQxPn81wM";
            var google_conversion_value = 0;
            /* ]]> */
            </script>
            <script type="text/javascript" src="https://www.googleadservices.com/pagead/conversion.js">
            </script>
            <noscript>
            <div style="display:inline;">
            <img height="1" width="1" style="border-style:none;" alt="" src="https://www.googleadservices.com/pagead/conversion/989805764/?label=1pFvCMypoAIQxPn81wM&amp;guid=ON&amp;script=0"/>
            </div>
            </noscript>'
        end
        redirect_to login_path
      else
        render :action=>"new"
      end
    end

end
