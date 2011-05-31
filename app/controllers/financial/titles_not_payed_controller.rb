class Financial::TitlesNotPayedController < ApplicationController
  before_filter :login_with_company_required,:except=>:show_financial
  before_filter :load_company,:except=>:show_financial

  layout "company"
  
  def index
    @titles = @company.titles_visible.paginate :page=>params[:page],:order=>"created_at desc"
  end

  def show_financial
    @title = Title.find(params[:id])
    @company = @title.company
    @layout = @company.layout
    show
    render :action=>:show,:layout=>false
  end

  def show
    @title = @company.titles.find(params[:id])
    @address = @company.address_business_card

    @nosso_numero =  @title.our_number  # Nosso numero - REGRA: Máximo de 13 caracteres!
    @numero_documento =  @title.id	# Num do pedido ou do documento
    @data_vencimento =  @title.due_date.strftime("%d/%m/%Y") # Data de Vencimento do Boleto - REGRA: Formato DD/MM/AAAA
    @data_documento =  Time.now.strftime("%d/%m/%Y") # Data de emissão do Boleto
    @data_processamento =  Time.now.strftime("%d/%m/%Y") # Data de processamento do boleto (opcional)
    @valor_boleto =  @title.value.to_s 	# Valor do Boleto - REGRA: Com vírgula e sempre com duas casas depois da virgula

    # DADOS DO SEU CLIENTE
    @sacado =  @company.cnpj.nil? ? @company.person_name : @company.razao_social
    @endereco1 =  "#{@address.street} #{@address.number} / #{@address.complement} - #{@address.neighborhood}"
    @endereco2 =  "#{@address.city} - #{@address.state} -  CEP: #{@address.zip}"

    data = []
    @title.additional_data.each{|s|data << s.chomp } unless @title.additional_data.nil?
    @instrucoes1 =  data[0].nil? ? "" : data[0]
    @instrucoes2 =  data[1].nil? ? "" : data[1]
    @instrucoes3 =  data[2].nil? ? "" : data[2]
    @instrucoes4 =  data[3].nil? ? "" : data[3]

    # DADOS OPCIONAIS DE ACORDO COM O BANCO OU CLIENTE
    @quantidade =  ""
    @valor_unitario =  ""
    @aceite =  "N"
    @especie =  "R$"
    @especie_doc =  ""
    @banco = "356"

    # ---------------------- DADOS FIXOS DE CONFIGURAÇÃO DO SEU BOLETO --------------- #
    # DADOS DA SUA CONTA - REAL
    @agencia =  Constant.find_value_by_key("agencia_cedente") # Num da agencia, sem digito
    @conta =  Constant.find_value_by_key("conta_cedente") 	# Num da conta, sem digito
    digitao = Title.calcula_digitao(@agencia,@conta,@nosso_numero)
    @agencia_codigo = "#{@agencia}/#{@conta}/#{digitao}"
    @carteira =  "20"  # Código da Carteira

    # SEUS DADOS
    @identificacao =  "#{I18n.t "company.site_title"} - serviços de internet"
    @cpf_cnpj =  Constant.find_value_by_key("cnpj_cedente")
    @endereco =  "Rua Duque de Caxias, 1.303 ap. 302, Bairro Centro"
    @cidade_uf =  "Porto Alegre / RS"
    @cedente =  Constant.find_value_by_key("nome_cedente")

    digitao_cod_barra = Title.calcula_digitao_cod_barra(@banco, @title.due_date,@valor_boleto,@agencia,@conta,digitao,@nosso_numero)

    @linha_digitavel = Title.create_linha_digitavel(@banco,@agencia,@conta,@nosso_numero,@title.value,digitao,@title.due_date,digitao_cod_barra)

    @codigo_barras = Title.fbarcode("#{@banco}9#{digitao_cod_barra.to_s}#{Title.due_factor(@title.due_date)}#{ShippingFile.fit_number((@valor_boleto.to_f*100).to_int,10)}#{@agencia}#{ShippingFile.fit_number @conta,7}#{digitao}#{ShippingFile.fit_number @nosso_numero,13}")

    @codigo_banco_com_dv = @banco << "-5"

    render :layout=>false
  end
end
