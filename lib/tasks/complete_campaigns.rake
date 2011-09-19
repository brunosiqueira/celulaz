desc "altera status de campanhas que tenham expirado"

task(:complete_campaigns => :environment) do
  business = Business.find(:all, :conditions => ['status = "Publicado"'])
  business.each do |b|
    if b.status == 'Publicado' && b.expired_at < Date.today
      b.status = 'Finalizado'
      b.save!
    end
  end
end