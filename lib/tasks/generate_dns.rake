desc "atualiza o arquivo dns com todos os sites"
task(:generate_dns => :environment) do
  puts "gerando arquivo"
  File.open DNS_PATH + "sites.com","w+" do |f|
    UserCompany.find(:all,:include=>:company,
      :conditions=>"companies.type = 'CompanyZ' and users.domain is not null").each do |user|
      user.domain.split(";").each do |domain|
        puts "gerando registro para #{user.login}"
        f.write " <VirtualHost *>\n"
        f.write "ServerAdmin suporte@celulaz.com.br\n"
        f.write "ServerName #{CGI::escape domain}\n"
        f.write "ServerAlias www.#{CGI::escape domain}\n"
        f.write "DocumentRoot /srv/www/celulaz.com.br/my-app/public/\n"
        f.write "<Directory /srv/www/celulaz.com.br/my-app/public/>\n"
        f.write "AllowOverride All\n"
        f.write "Order allow,deny\n"
        f.write "Allow from all\n"
        f.write  " </Directory>\n"
        f.write "DirectoryIndex sites/#{user.login}/index.html\n"
        f.write "ErrorLog /srv/www/celulaz.com.br/logs/error.log\n"
        f.write "CustomLog /srv/www/celulaz.com.br/logs/access.log combined\n"
        f.write "</VirtualHost>\n\n"
      end
    end
    puts "arquivo gerado com sucesso"
  end
end