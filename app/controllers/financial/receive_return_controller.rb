require "app/util/return_file"
class Financial::ReceiveReturnController < Financial::ShippingsController

  before_filter :login_as_director_required

  layout "new_admin"

  def new
    
  end

  def create
    if params[:return].nil? || params[:return].blank?
      flash[:notice]="Selecionar um arquivo de retorno."
      render :action=>:new
    else
       @titles = []
      path = "backup/files/return/#{Time.now.strftime("%y%m%d%H%M")}_#{params[:return].original_filename}"
      file = File.new(path, 'w+')
      file.write(params[:return].read)
      file.close
      file = File.new(path)
      if ReturnFile.valid_return_file?(file)
        @titles = ReturnFile.process_return_file file
        unless @titles.empty?
          flash[:notice] = "Processamento realizado com sucesso"
        else
          flash[:error] = "Não foi possível realizar a operação. Nenhum título foi localizado durante o processamento."
        end
      else
        flash[:error] = "Formato de arquivo de retorno inválido."
      end
      file.close
      render :action => "show"
    end
  end


end
