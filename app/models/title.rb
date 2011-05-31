# == Schema Information
# Schema version: 20110315144312
#
# Table name: titles
#
#  id                    :integer(4)      not null, primary key
#  company_id            :integer(4)
#  contract_id           :integer(4)
#  emission_date         :date
#  due_date              :date
#  value                 :float
#  fine_percent          :float
#  days_to_charge_fine   :integer(2)
#  interest_percent      :float
#  abatement_value       :float
#  discount_value        :float
#  discount_type         :string(255)
#  discount_limit_date   :date
#  additional_data       :string(800)
#  created_at            :datetime
#  updated_at            :datetime
#  status                :string(255)     default("Digitado")
#  our_number            :string(7)
#  your_number           :string(10)
#  occurrency            :string(2)
#  occurrency_complement :string(2)
#  interest_type         :string(1)
#  error_message         :string(255)
#

class Title < ActiveRecord::Base
  DISCOUNT_TYPE_LIST = ["Sem desconto","Até data limíte","Por dia de antecipação"]
  STATUS_DIGITADO = "Digitado"
  STATUS_SELECIONADO = "Selecionado"
  STATUS_ENVIADO = "Enviado"
  STATUS_ACATADO = "Acatado"
  STATUS_RECUSADO = "Recusado"
  STATUS_LIQUIDADO = "Liquidado"
  STATUS_BAIXADO = "Baixado"
  STATUS_LIST = [STATUS_DIGITADO,
              STATUS_SELECIONADO,
              STATUS_ENVIADO,
              STATUS_ACATADO,
              STATUS_RECUSADO,
              STATUS_LIQUIDADO,
              STATUS_BAIXADO]
  INTEREST_TYPE_LIST = [["0","Valor/dia"],["1","Taxa/mês"]]
  belongs_to :company
  belongs_to :contract
  has_many :shipping_titles, :dependent=>:destroy
  validates_presence_of :company,:contract,:due_date,:value,:emission_date,:your_number
  validates_inclusion_of :discount_type, :in=>DISCOUNT_TYPE_LIST
  validates_inclusion_of :status, :in=>STATUS_LIST
  validates_presence_of :discount_value,:if=>:discount_type_not_sem_desconto
  validates_presence_of :interest_percent,:if=>:interest_type_not_blank
  usar_como_dinheiro :value,:discount_value,:abatement_value
  validates_uniqueness_of :due_date, :scope=>:your_number,:message=>:due_date_unique

  before_create :status_default
  before_create :our_number_nil

  def select!
    self.update_attribute :status,STATUS_SELECIONADO
  end

  def send!
    self.update_attribute :status, STATUS_ENVIADO
  end

  def restart!
    self.update_attribute :status, STATUS_DIGITADO
  end

  def payed?
    self.status == STATUS_LIQUIDADO
  end

  def can_generate?
    self.status != STATUS_LIQUIDADO && !self.our_number.nil?
  end

  def Title.discount_type_list
    DISCOUNT_TYPE_LIST
  end

  def Title.status_list
    STATUS_LIST
  end

  def Title.interest_type_list
    INTEREST_TYPE_LIST
  end

  def Title.find_all_available
    Title.find :all,:conditions=>{:status=>STATUS_DIGITADO}
  end

  def to_s
    "#{self.due_date.to_s_br} - #{company ? company.razao_social : ""} - R$ #{self.value.real}"
  end
  
  def Title.update_title(detail)
    our_number = detail[64,7].to_i
    occurrency = detail[108,2]
    your_number = detail[116,10].strip
    d,m,y = detail[146,2],detail[148,2],detail[150,2]
    due_date =  Date.new "20#{y}".to_i, m.to_i, d.to_i
    occurrency_complement = detail[339,2]
    error_message = detail[341,50]
    title = Title.find_by_your_number_and_due_date your_number, due_date
    if title && !title.payed?
      title.update_attributes :error_message=>error_message ,:our_number => our_number, :occurrency=>occurrency, :occurrency_complement=>occurrency_complement, :status => Title.update_status(occurrency)
      title
    else
      nil
    end
  end

  def Title.calcula_digitao(agencia,conta,nosso_numero)
    line = "#{ShippingFile.fit_number nosso_numero,13}#{ShippingFile.fit_number agencia,4}#{ShippingFile.fit_number conta,7}"
    Title.create_digit(line)
  end

  def Title.calcula_digitao_cod_barra(banco, data_vencimento,valor,agencia,conta,digitao,nosso_numero)
    wheights = "4329876543298765432987654329876543298765432"
    line = "#{banco}9#{due_factor(data_vencimento)}#{ShippingFile.fit_number((valor.to_f*100).to_int,10)}#{ShippingFile.fit_number agencia,4}#{ShippingFile.fit_number conta,7}#{digitao}#{ShippingFile.fit_number nosso_numero,13}"
    result = 0
    length = line.length
    (length-1).downto(0) { |i|
      aux = line[i,1].to_i * wheights[i,1].to_i
      result += aux
    }
    d = 11 - (result % 11)
    return d >= 10 ? 1 : d
  end

  def Title.create_digit(line)
    result = 0
    length = line.length
    (length-1).downto(0) { |i|
      aux = line[i,1].to_i * ((length-i) % 2 > 0 ? 2 : 1 )
      aux = 1 + (aux % 10) if aux >=10

      result += aux
    }
    result = 10 - (result % 10)
    return result > 9 ? 0 : result
  end

  def Title.create_linha_digitavel(banco,agencia,conta,nosso_numero,valor,digitao,data_vencimento,digitao_cod_barra)
    bloco1 = "#{banco}9#{ShippingFile.fit_number agencia,4}#{conta[0,1]}"
    bloco1 << create_digit(bloco1).to_s

    bloco2 = "#{conta[1,6]}#{digitao}#{ShippingFile.fit_number(nosso_numero,13)[0,3]}"
    bloco2 << create_digit(bloco2).to_s

    bloco3 = ShippingFile.fit_number(nosso_numero,13)[3,10]
    bloco3 << create_digit(bloco3).to_s

    bloco4 = "#{due_factor(data_vencimento)}#{ShippingFile.fit_number((valor.to_f*100).to_int,10)}"
    return "#{bloco1[0,5]}.#{bloco1[5,5]} #{bloco2[0,5]}.#{bloco2[5,6]} #{bloco3[0,5]}.#{bloco3[5,6]} #{digitao_cod_barra.to_s} #{bloco4}"
  end

  def Title.fbarcode(valor)
    fino = "1"
    largo = "3"
    altura = "50"
    barcodes = %w(00110 10001 01001 11000 00101 10100 01100 00011 10010 01010)

    #Desenho da barra
    barra = ""
    #Guarda inicial
    barra << "<img src=\"/images/boleto/p.png\" width=#{fino} height=#{altura} border=0>"
    barra << "<img src=\"/images/boleto/b.png\" width=#{fino} height=#{altura} border=0>"
    barra << "<img src=\"/images/boleto/p.png\" width=#{fino} height=#{altura} border=0>"
    barra << "<img src=\"/images/boleto/b.png\" width=#{fino} height=#{altura} border=0>"

    valor = "0"<<valor if valor.length % 2 != 0
    size = 0

    while size < valor.length do
      n1 = size
      n2 = size + 1
      b1 = barcodes[valor[n1,1].to_i]
      b2 = barcodes[valor[n2,1].to_i]
      0.upto(4) { |i|
        
        f1 = b1[i,1] == "0" ? fino : largo
        f2 = b2[i,1] == "0" ? fino : largo
        barra << "<img src=\"/images/boleto/p.png\" width=#{f1} height=#{altura} border=0>"
        barra << "<img src=\"/images/boleto/b.png\" width=#{f2} height=#{altura} border=0>"
      }
      size +=2
    end
    # Draw guarda final
    barra << "<img src=\"/images/boleto/p.png\" width=#{largo} height=#{altura} border=0>"
    barra << "<img src=\"/images/boleto/b.png\" width=#{fino} height=#{altura} border=0>"
    barra << "<img src=\"/images/boleto/p.png\" width=#{fino} height=#{altura} border=0>"
    return barra
  end #Fim da função

  def Title.due_factor(due_date)
    fator = due_date - Date.strptime("03/07/2000", "%d/%m/%Y")
    fator.to_i + 1000
  end

  private

  def Title.update_status(occurrency)
    if %w(05 06 07).include? occurrency
      return STATUS_LIQUIDADO
    elsif  %w(08 09 10).include? occurrency
      return STATUS_BAIXADO
    elsif  "02" == occurrency
      return STATUS_ACATADO
    elsif  "03" == occurrency
      return STATUS_RECUSADO
    end
  end

  def status_default
    self.status = STATUS_DIGITADO
  end

  def discount_type_not_sem_desconto
    !"Sem desconto".eql?(self.discount_type)
  end

  def interest_type_not_blank
    !self.interest_type.nil? && !self.interest_type.blank?
  end

  def our_number_nil
    self.our_number = nil
  end
end
