# To change this template, choose Tools | Templates
# and open the template in the editor.

module ShippingFile

  #Cria o arquivo para envio para o banco para gerar cobranças
  def ShippingFile.create_file(shipping)
    file = File.new("backup/files/shipping/#{shipping.code}_#{Time.now.strftime("%d%m%y%H%M")}.txt", 'w+')
    file.write "#{create_header(shipping).chomp}\n"
    order = 2
    shipping.titles.each { |title|
      file.write "#{create_detail(title, order).chomp}\n"
      order+=1
      file.write "#{create_message(title, order).chomp}\n"
      order+=1
    }
    file.write "#{create_trailler(order,shipping).chomp}\n"
    file
  end

  private

  def ShippingFile.create_header(shipping)
    header = " "*400
    header[0,1] = "0"
    header[1,25] = fit_string "1REMESSA01COBRANCA",25
    header[26,1] = "0"
    header[27,4] = fit_number Constant.find_value_by_key("agencia_cedente"),4 #Agência do cedente
    header[31,1] = "0"
    header[32,7] = fit_number Constant.find_value_by_key("conta_cedente"),7 #Conta do cedente
    header[46,30] = fit_string(Constant.find_value_by_key("nome_cedente"),30) #Nome do cedente
    header[76,3] = "356" #Identificação do banco
    header[79,15] = fit_string("Banco Real",15) #Nome do banco
    header[94,6] = fit_date shipping.processing_date #Data do Processamento
    header[100,8] = "01600BPI"
    header[394,6] = fit_number "1",6 #Número Sequencial do registro no arquivo
    header
  end

  def ShippingFile.create_detail(title,order_number)
    detail = " "*400
    detail[0,1] = "1"
    detail[1,2] = "02" #'01'-CPF, '02'-CNPJ
    detail[3,8] =  Constant.find_value_by_key("cnpj_cedente")[0,8] #CPF, CNPJ do cedente
    detail[11,4] = Constant.find_value_by_key("cnpj_cedente")[8,4] #Filial
    detail[15,2] = Constant.find_value_by_key("cnpj_cedente")[12,2] #Controle
    detail[17,1] = "0"
    detail[18,4] = fit_number Constant.find_value_by_key("agencia_cedente"),4 #Agência do cedente
    detail[22,1] = "0"
    detail[23,7] = fit_number Constant.find_value_by_key("conta_cedente"),7 #Conta do cedente
    detail[37,25] = fit_string("",25) #campo especial - Uso livre do cedente
    detail[62,2] = "00"
    detail[64,7] = fit_number title.our_number,7 # Num do titulo no banco
    detail[71,1] = "0"
    detail[72,2] = fit_number(title.days_to_charge_fine.to_s,2) #Dias para multa
    detail[74,1] = "1" #Tipo multa
    detail[75,13] = fit_number((title.fine_percent.nil? ? 0 : title.fine_percent*100).to_int,13) #Taxa de multa
    detail[95,9] = fit_number "",9 #número do contrato - usado na cobrança real ou caucionada
    detail[105,2] = "00" #Código da carteira -  Carteira do convenio
    detail[107,1] = "5" #Cobrança simples
    detail[108,2] = "01" #Código da ocorrência - entrada
    detail[110,10] = fit_string title.your_number,10 #Num. Título (cedente)
    detail[120,6] = fit_date title.due_date  #Data de vencimento
    detail[126,13] = fit_number((title.value.to_f*100).to_int,13) #valor do título
    detail[139,3] = "356" #Identificação do banco
    detail[147,2] = "06" #Espécie de Título - Banco emitirá bloquetos
    detail[149,1] = "A" #Aceite - Sim
    detail[150,6] = fit_date title.emission_date #Data de emissão
    detail[156,2] = "99" #Código do protesto - Não protestar
    detail[160,1] = fit_string title.interest_type,1 #Tipo de juros
    detail[161,12] = fit_number((title.interest_percent.nil? ? 0 : title.interest_percent*100).to_int,12) #Juros de mora - V99 - valor/dia ou taxa/mês
    detail[173,6] = fit_date title.discount_limit_date #Data limite para o desconto
    detail[179,13] = fit_number((title.discount_value.nil? ? 0 : title.discount_value.to_f*100).to_int,13) # Valor desconto
    detail[205,13] = fit_number((title.abatement_value.nil? ? 0 : title.abatement_value.to_f*100).to_int,13) #Abatimento

    company = title.company
    if company.cnpj.nil? || company.cnpj.to_s.blank?
      #Se cpf
      person = company.user.person
      cpf = person.cpf.to_s
      cpf.gsub! ".",""
      cpf.gsub! "-",""
      detail[218,2] = "01" #código do cpf
      detail[220,9] = cpf[0,9] #Corpo do cpf
      detail[229,3] = "000"
      detail[232,2] = cpf[9,2] #Controle do cpf
      detail[234,40] = fit_string(person.name,40)#Nome do sacado
    else
      #Se CNPJ
      cnpj = company.cnpj.to_s
      cnpj.gsub! ".",""
      cnpj.gsub! "-",""
      cnpj.gsub! "/",""
      detail[218,2] = "02" #código do cnpj
      detail[220,8] = cnpj[0,8] #Corpo CNPJ
      detail[228,4] = cnpj[8,4] #Filial
      detail[232,2] = cnpj[12,2] #Controle do cnpj
      detail[234,40] = fit_string(company.razao_social,40)#Nome do sacado
    end
    #Fim

    detail[274,40] = fit_string("#{company.address_business_card.street} #{company.address_business_card.number} #{company.address_business_card.complement} ",40)#Endereço do sacado
    detail[314,12] = fit_string(company.address_business_card.neighborhood,12)#Bairro
    detail[326,5] = company.address_business_card.zip[0,5] #CEP
    detail[331,3] = company.address_business_card.zip[6,3] #Complemento do CEP
    detail[334,15] = fit_string(company.address_business_card.city,15) #Cidade
    detail[349,2] = fit_string(company.address_business_card.state,2) #Estado
    detail[351,40] = fit_string("",40) #Nome do sacador
    detail[391,1] = "0" #Reais
    detail[392,2] = "07" #Reais
    detail[394,6] = fit_number order_number,6 #Número Sequencial do registro no arquivo
    detail
  end

  def ShippingFile.create_message(title,order_number)
    message = " "*400
    message[0,1] = "8"
    message[1,1] = "1" #Sequência Reg. Mens.: 1,2,3,4
    message[2,1] = "0"
    message[3,4] = fit_number Constant.find_value_by_key("agencia_cedente"),4 #Agência do cedente
    message[7,1] = "0"
    message[8,7] = fit_number Constant.find_value_by_key("conta_cedente"),7 #Conta do cedente
    message[15,10] = fit_string title.your_number,10 #Num. Título (cedente)
    data = []
    title.additional_data.each{|s|data << s.chomp }
    unless data[0].nil?
      message[25,69] = fit_string data[0].chomp,69 #Mensagem 1
      message[94,1] = "3" #Cod Local Mensagem 1
    else
      message[25,70] = fit_string " ",70
    end
    unless data[1].nil?
      message[95,69] = fit_string data[1].chomp,69 #Mensagem 2
      message[164,1] = fit_string "3",1 #Cod Local Mensagem 2
    else
      message[95,70] = fit_string " ",70
    end
    unless data[2].nil?
      message[165,69] = fit_string data[2].chomp,69 #Mensagem 3
      message[234,1] =  "3" #Cod Local Mensagem 3
    else
      message[165,70] = fit_string " ",70
    end
    unless data[3].nil?
      message[235,69] = fit_string data[3].chomp,69 #Mensagem 4
      message[304,1] = "3" #Cod Local Mensagem 4
    else
      message[235,70] = fit_string " ",70
    end
    unless data[4].nil?
      message[305,69] = fit_string data[4].chomp,69 #Mensagem 5
      message[374,1] = "3" #Cod Local Mensagem 5
    else
      message[305,70] = fit_string " ",70
    end
    message[394,6] = fit_number order_number,6 #Número Sequencial do registro no arquivo
    message
  end

  def ShippingFile.create_trailler(order_number,shipping)
    trailler = " "*400
    trailler[0,1] = fit_number '9',1
    trailler[1,6] = fit_number(shipping.titles.size.to_s,6) #Quantidade de títulos
    trailler[7,13] = fit_number((shipping.total_value.to_f*100).to_int.to_s,13) #Valor total
    trailler[20,374] = fit_string "", 374
    trailler[394,6] = fit_number order_number,6 #Número Sequencial do registro no arquivo
    trailler
  end

  
  def ShippingFile.fit_string(field,size,alpha=true)
    string = field.nil? ? "" : field.to_s
    token = alpha ? " " : "0"
    if string.length >= size
      return alpha ? string[0,size] : string[string.length-size,string.length]
    else
      return alpha ? string.insert(string.length,token*(size - string.length)) : string.insert(0,token*(size - string.length))
    end
  end

  def ShippingFile.fit_number(field,size)
    fit_string field,size,false
  end

  def ShippingFile.fit_date(field)
    field ? field.strftime("%d%m%y") : fit_string("",6)
  end
end
