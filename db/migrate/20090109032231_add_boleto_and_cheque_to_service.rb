class AddBoletoAndChequeToService < ActiveRecord::Migration
  def self.up
    Service.create :title=>"Pagamento Boleto",:image_path=>"Pg_Boleto.jpg"
    Service.create :title=>"Pagamento Cheque",:image_path=>"Pg_Cheque.jpg"
  end

  def self.down
    titles = ["Pagamento Boleto","Pagamento Cheque"]
    for title in titles do
      service = Service.find_by_title title
      Service.destroy(service.id) if service
    end
  end
end
