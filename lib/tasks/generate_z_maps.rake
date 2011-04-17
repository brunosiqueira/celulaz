desc "gera a lista de sites e envia por email para cadastrar no google"
task(:generate_z_maps => :environment) do
  puts "generating site map"
  time_mod = Time.now.strftime("%Y-%m-%d")
  file = File.new("public/sitemap.xml", 'w+')
  file.write "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
  file.write "<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">"
  file.write "<url><loc>http://#{SITE_URL}/</loc><lastmod>#{time_mod}</lastmod><changefreq>monthly</changefreq><priority>0.5</priority></url>"
  file.write "<url><loc>http://#{SITE_URL}/search</loc><lastmod>#{time_mod}</lastmod><changefreq>monthly</changefreq><priority>0.5</priority></url>"
  users = UserCompany.find :all, :include=>:company,:conditions=>["companies.type = ?",CompanyZ.name]
  users.each { |user|
    puts "inserting user site: #{user.login}"
    file.write "<url><loc>http://#{SITE_URL}/z/#{URI::escape user.login}</loc><lastmod>#{time_mod}</lastmod><changefreq>weekly</changefreq><priority>0.5</priority></url>"
  }
  file.write "</urlset>"
  file.close
  puts "site map finished"
end