class CreateBanks < ActiveRecord::Migration
  def self.up
    create_table :banks do |t|
      t.integer :code,:limit=>3,:null=>false
      t.string :name,:null=>false

      t.timestamps
    end
    
    add_index(:banks, :code,:unique => true )

    Bank.create :name=>"BANCO A.J. RENNER S.A.",:code=>654
    Bank.create :code=>246, :name=>"BANCO ABC BRASIL S.A."
    Bank.create :code=>356, :name=>"BANCO ABN AMRO REAL S.A."
    Bank.create :code=>25, :name=>"BANCO ALFA S/A."
    Bank.create :code=>213, :name=>"BANCO ARBI S.A."
    Bank.create :code=>29, :name=>"BANCO BANERJ S.A."
    Bank.create :code=>719, :name=>"BANCO BANIF PRIMUS S.A."
    Bank.create :code=>107, :name=>"BANCO BBM S.A."
    Bank.create :code=>291, :name=>"BANCO BCN S.A."
    Bank.create :code=>34, :name=>"BANCO BEA S.A."
    Bank.create :code=>48, :name=>"BANCO BEMGE S.A."
    Bank.create :code=>739, :name=>"BANCO BGN S.A."
    Bank.create :code=>96, :name=>"BANCO BM&F DE SERV. DE LIQUIDAÇÃO E CUSTODIA S.A."
    Bank.create :code=>394, :name=>"BANCO BMC S.A."
    Bank.create :code=>318, :name=>"BANCO BMG S.A."
    Bank.create :code=>116, :name=>"BANCO BNL DO BRASIL S.A."
    Bank.create :code=>752, :name=>"BANCO BNP PARIBAS BRASIL S.A."
    Bank.create :code=>231, :name=>"BANCO BOAVISTA INTERATLANTICO S.A-EM ABSORCAO"
    Bank.create :code=>218, :name=>"BANCO BONSUCESSO S.A."
    Bank.create :code=>237, :name=>"BANCO BRADESCO S.A."
    Bank.create :code=>225, :name=>"BANCO BRASCAN S.A."
    Bank.create :code=>44, :name=>"BANCO BVA SA"
    Bank.create :code=>263, :name=>"BANCO CACIQUE S.A."
    Bank.create :code=>222, :name=>"BANCO CALYON BRASIL S/A"
    Bank.create :code=>412, :name=>"BANCO CAPITAL S.A."
    Bank.create :code=>266, :name=>"BANCO CEDULA S.A."
    Bank.create :code=>745, :name=>"BANCO CITIBANK S.A."
    Bank.create :code=>215, :name=>"BANCO COMERCIAL E DE INVESTIMENTO SUDAMERIS S.A"
    Bank.create :code=>753, :name=>"BANCO COMERCIAL URUGUAI S.A."
    Bank.create :code=>756, :name=>"BANCO COOPERATIVO DO BRASIL S.A."
    Bank.create :code=>748, :name=>"BANCO COOPERATIVO SICREDI S.A. - BANSICREDI"
    Bank.create :code=>721, :name=>"BANCO CREDIBEL S.A."
    Bank.create :code=>505, :name=>"BANCO CREDIT SUISSE FIRST BOSTON S.A."
    Bank.create :code=>229, :name=>"BANCO CRUZEIRO DO SUL S.A."
    Bank.create :code=>3, :name=>"BANCO DA AMAZONIA S.A."
    Bank.create :code=>707, :name=>"BANCO DAYCOVAL S.A."
    Bank.create :code=>495, :name=>"BANCO DE LA PROVINCIA DE BUENOS AIRES"
    Bank.create :code=>494, :name=>"BANCO DE LA REPUBLICA ORIENTAL DEL URUGUAY"
    Bank.create :code=>24, :name=>"BANCO DE PERNAMBUCO S.A.-BANDEPE"
    Bank.create :code=>456, :name=>"BANCO DE TOKYO MITSUBISHI BRASIL S.A."
    Bank.create :code=>214, :name=>"BANCO DIBENS S.A."
    Bank.create :code=>1, :name=>"BANCO DO BRASIL S.A."
    Bank.create :code=>27, :name=>"BANCO DO ESTADO DE SANTA CATARINA S.A."
    Bank.create :code=>47, :name=>"BANCO DO ESTADO DE SERGIPE S.A."
    Bank.create :code=>35, :name=>"BANCO DO ESTADO DO CEARA S.A. BEC"
    Bank.create :code=>36, :name=>"BANCO DO ESTADO DO MARANHAO S.A.-BEM"
    Bank.create :code=>37, :name=>"BANCO DO ESTADO DO PARA S.A."
    Bank.create :code=>39, :name=>"BANCO DO ESTADO DO PIAUI S.A.-BEP"
    Bank.create :code=>41, :name=>"BANCO DO ESTADO DO RIO GRANDE DO SUL S.A."
    Bank.create :code=>4, :name=>"BANCO DO NORDESTE DO BRASIL S.A."
    Bank.create :code=>743, :name=>"BANCO EMBLEMA S.A."
    Bank.create :code=>265, :name=>"BANCO FATOR S.A."
    Bank.create :code=>224, :name=>"BANCO FIBRA S.A."
    Bank.create :code=>626, :name=>"BANCO FICSA S.A."
    Bank.create :code=>175, :name=>"BANCO FINASA S.A."
    Bank.create :code=>252, :name=>"BANCO FININVEST S.A."
    Bank.create :code=>233, :name=>"BANCO GE CAPITAL S.A."
    Bank.create :code=>734, :name=>"BANCO GERDAU S.A."
    Bank.create :code=>612, :name=>"BANCO GUANABARA S.A."
    Bank.create :code=>63, :name=>"BANCO IBI S.A - BANCO MULTIPLO"
    Bank.create :code=>604, :name=>"BANCO INDUSTRIAL DO BRASIL S.A."
    Bank.create :code=>320, :name=>"BANCO INDUSTRIAL E COMERCIAL S.A."
    Bank.create :code=>653, :name=>"BANCO INDUSVAL S.A."
    Bank.create :code=>630, :name=>"BANCO INTERCAP S.A."
    Bank.create :code=>77, :name=>"BANCO INTERMEDIUM S.A."
    Bank.create :code=>249, :name=>"BANCO INVESTCRED UNIBANCO S.A."
    Bank.create :code=>341, :name=>"BANCO ITAU S.A."
    Bank.create :code=>74, :name=>"BANCO J. SAFRA S.A."
    Bank.create :code=>217, :name=>"BANCO JOHN DEERE S.A."
    Bank.create :code=>600, :name=>"BANCO LUSO BRASILEIRO S.A."
    Bank.create :code=>212, :name=>"BANCO MATONE S.A."
    Bank.create :code=>243, :name=>"BANCO MAXIMA S.A."
    Bank.create :code=>389, :name=>"BANCO MERCANTIL DO BRASIL S.A."
    Bank.create :code=>746, :name=>"BANCO MODAL S.A."
    Bank.create :code=>738, :name=>"BANCO MORADA S.A."
    Bank.create :code=>151, :name=>"BANCO NOSSA CAIXA S.A."
    Bank.create :code=>45, :name=>"BANCO OPPORTUNITY S.A."
    Bank.create :code=>208, :name=>"BANCO PACTUAL S.A."
    Bank.create :code=>623, :name=>"BANCO PANAMERICANO S.A."
    Bank.create :code=>611, :name=>"BANCO PAULISTA S.A."
    Bank.create :code=>650, :name=>"BANCO PEBB S.A."
    Bank.create :code=>613, :name=>"BANCO PECUNIA S.A."
    Bank.create :code=>643, :name=>"BANCO PINE S.A."
    Bank.create :code=>735, :name=>"BANCO POTTENCIAL S.A."
    Bank.create :code=>638, :name=>"BANCO PROSPER S.A."
    Bank.create :code=>747, :name=>"BANCO RABOBANK INTERNATIONAL BRASIL S.A."
    Bank.create :code=>216, :name=>"BANCO REGIONAL MALCON S.A."
    Bank.create :code=>633, :name=>"BANCO RENDIMENTO S.A."
    Bank.create :code=>741, :name=>"BANCO RIBEIRAO PRETO S.A."
    Bank.create :code=>453, :name=>"BANCO RURAL S.A."
    Bank.create :code=>422, :name=>"BANCO SAFRA S.A."
    Bank.create :code=>353, :name=>"BANCO SANTANDER BRASIL S.A."
    Bank.create :code=>8, :name=>"BANCO SANTANDER MERIDIONAL S.A."
    Bank.create :code=>33, :name=>"BANCO SANTANDER S.A."
    Bank.create :code=>351, :name=>"BANCO SANTANDER S.A."
    Bank.create :code=>250, :name=>"BANCO SCHAHIN S.A."
    Bank.create :code=>366, :name=>"BANCO SOCIETE GENERALE BRASIL S.A."
    Bank.create :code=>637, :name=>"BANCO SOFISA S.A."
    Bank.create :code=>347, :name=>"BANCO SUDAMERIS DO BRASIL S.A."
    Bank.create :code=>464, :name=>"BANCO SUMITOMO MITSUI BRASILEIRO S.A."
    Bank.create :code=>634, :name=>"BANCO TRIANGULO S.A."
    Bank.create :code=>247, :name=>"BANCO UBS S.A."
    Bank.create :code=>655, :name=>"BANCO VOTORANTIM S.A."
    Bank.create :code=>610, :name=>"BANCO VR S.A."
    Bank.create :code=>370, :name=>"BANCO WESTLB DO BRASIL S.A."
    Bank.create :code=>219, :name=>"BANCO ZOGBI S.A."
    Bank.create :code=>62, :name=>"BANCO1.NET S.A."
    Bank.create :code=>28, :name=>"BANEB-EM ABSORCAO"
    Bank.create :code=>21, :name=>"BANESTES S.A BANCO DO ESTADO DO ESPIRITO SANTO"
    Bank.create :code=>479, :name=>"BANKBOSTON BANCO MULTIPLO S.A."
    Bank.create :code=>73, :name=>"BB BANCO POPULAR DO BRASIL"
    Bank.create :code=>749, :name=>"BR BANCO MERCANTIL S.A."
    Bank.create :code=>70, :name=>"BRB - BANCO DE BRASILIA S.A."
    Bank.create :code=>104, :name=>"CAIXA ECONOMICA FEDERAL"
    Bank.create :code=>487, :name=>"DEUTSCHE BANK S. A. - BANCO ALEMAO"
    Bank.create :code=>210, :name=>"DRESDNER BANK LATEINAMERIKA AKTIENGESELLSCHAFT"
    Bank.create :code=>399, :name=>"HSBC BANK BRASIL S.A.-BANCO MULTIPLO"
    Bank.create :code=>76, :name=>"KDB DO BRASIL"
    Bank.create :code=>65, :name=>"LEMON BANK BANCO MULTIPLO S.A."
    Bank.create :code=>30, :name=>"PARAIBAN-BANCO DA PARAIBA S.A."
    Bank.create :code=>254, :name=>"PARANA BANCO S.A."
    Bank.create :code=>409, :name=>"UNIBANCO - UNIAO DE BANCOS BRASILEIROS S.A."
    Bank.create :code=>230, :name=>"UNICARD BANCO MULTIPLO S.A."
    Bank.create :code=>999, :name=>" >>>      BANCO INEXISTENTE OU INDISPONÍVEL.      <<< "
  end

  def self.down
    drop_table :banks
  end
end
