#create admin user
user = UserAdministrator.new
user.login = "admin"
user.email = "bsiqueira@gmail.com"
user.password = "admin"
user.password_confirmation = "admin"
user.save(false)
user.send(:activate!)
user.save!

#add person to admin user
user.person = Person.new(:name=>'Bruno Siqueira',:cpf=>'099.033.907-69', :rg=> '11423950-2',
  :rg_exp=> 'IFP', :rg_exp_date=> '1995-05-24', :date_birth=> '1983-02-08',:neighborhood=>'Icaraí',
  :city=> 'Niterói', :zip=> '24220-041', :number=> '54', :street=> 'Rua Presidente Backer')
user.save!

#adding file to segment
Segment.transaction do
  segments = [['Alimentação','alimentacao.jpg'],
    ['Casa','casa.jpg'],
    ['Comércio','comercio.jpg'],
    ['Diversão','diversao.jpg'],
    ['Educação','educacao.jpg'],
    ['Saúde','saude.jpg'],
    ['Transporte','transporte.jpg'],
    ['Viagem','viagem.jpg'],
    ['Outros','outros.jpg'],
    ['Autonomos','autonomos.jpg']]

  for title,file in segments do
    segment = Segment.find_by_name title
    segment.file = file
    segment.save!
  end
end
#adding segment to segment
Segment.transaction do
  segment = Segment.find_by_name "Viagem"
  segment.name = "Diversão e Viagem"
  segment.save!
end

#remove autonomos from segment
segment = Segment.find_by_name "Autonomos"
Segment.destroy segment.id