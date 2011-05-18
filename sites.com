 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName oticadinizrs.com.br
ServerAlias www.oticadinizrs.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/oticadiniz/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName taiart.com
ServerAlias www.taiart.com
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/taiart/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName omniope.com
ServerAlias www.omniope.com
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/omniope/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName brasdental.com
ServerAlias www.brasdental.com
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/brasdental/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName centraldevidros.com.br
ServerAlias www.centraldevidros.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/centralvidros/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName saraivamendonca.com.br
ServerAlias www.saraivamendonca.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/saraivamendonca/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName qualityvidros.com.br
ServerAlias www.qualityvidros.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/qualityvidros/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName houseinglass.com.br
ServerAlias www.houseinglass.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/houseinglass/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName mezzoporto.com.br
ServerAlias www.mezzoporto.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/mezzoporto/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName crpadrechagas.com.br
ServerAlias www.crpadrechagas.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/crchagas/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName concelcom.com.br
ServerAlias www.concelcom.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/concelcom/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName dolcerelax.com.br
ServerAlias www.dolcerelax.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/dolcerelax/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName blusasecia.com.br
ServerAlias www.blusasecia.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/blusasecia/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName raia1.com.br
ServerAlias www.raia1.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/raia1/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName lavanderiakodama.com.br
ServerAlias www.lavanderiakodama.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/kodama/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName office-moveis.com
ServerAlias www.office-moveis.com
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/officemoveis/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName esteticamarinesqueiroz.com.br
ServerAlias www.esteticamarinesqueiroz.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/esteticamariainesqueiroz/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName lojahot.com
ServerAlias www.lojahot.com
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/hot/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName bikerboysrs.com.br
ServerAlias www.bikerboysrs.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/bikerboys/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName misstrass.com.br
ServerAlias www.misstrass.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/misstrass/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName galeriaedelweiss.com.br
ServerAlias www.galeriaedelweiss.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/edelweiss/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName upsportsbrasil.com
ServerAlias www.upsportsbrasil.com
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/upsports/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName oxt.com.br
ServerAlias www.oxt.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/oxt/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName irresistiblehair.com.br
ServerAlias www.irresistiblehair.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/telis/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName projetvidros.com.br
ServerAlias www.projetvidros.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/projetvidros/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName felipedetanico.com.br
ServerAlias www.felipedetanico.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/felipedetanico/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName armazemventura.com
ServerAlias www.armazemventura.com
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/armazemventura/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName uroclinilife.com.br
ServerAlias www.uroclinilife.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/fernandobastos/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName centrocoracaodemae.com.br
ServerAlias www.centrocoracaodemae.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/coracaodemae/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName emza.com.br
ServerAlias www.emza.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/Emza/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName alquimiainterior.com.br
ServerAlias www.alquimiainterior.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/alquimiainterior/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName fabrinonunes.com.br
ServerAlias www.fabrinonunes.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/fabrino/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName digdoggystore.com.br
ServerAlias www.digdoggystore.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/digdoggy/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName nrconsultoria.com.br
ServerAlias www.nrconsultoria.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/nrconsultoria/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName desinsetizadorasegura.com
ServerAlias www.desinsetizadorasegura.com
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/segura/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName anacidade.com.br
ServerAlias www.anacidade.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/anacarolina/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName tangerinacestas.com.br
ServerAlias www.tangerinacestas.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/tangerinacestas/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName tipoboteco.com.br
ServerAlias www.tipoboteco.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/botecoexportacao/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName tumeleroadvogados.com.br
ServerAlias www.tumeleroadvogados.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/tumelerobiavatti/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName plcopiadoras.com.br
ServerAlias www.plcopiadoras.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/plcopiadoras/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName lfernando.com
ServerAlias www.lfernando.com
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/luisfernando/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName thalesjr.com.br
ServerAlias www.thalesjr.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/thales/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName projetglass.com.br
ServerAlias www.projetglass.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/projetglass/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName pagodeplanob.com.br
ServerAlias www.pagodeplanob.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/planob/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName acogalvano.com.br
ServerAlias www.acogalvano.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/acogalvano/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName cursosjanebarros.com.br
ServerAlias www.cursosjanebarros.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/janebarros/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName divinosaborgrill.com.br
ServerAlias www.divinosaborgrill.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/vitrinedosabor/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName danielladeleon.com.br
ServerAlias www.danielladeleon.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/danielladeleon/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName tonmedeiros.com.br
ServerAlias www.tonmedeiros.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/tonmedeiros/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName fveiga.com.br
ServerAlias www.fveiga.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/fernandoveiga/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName depilclinestetica.com.br
ServerAlias www.depilclinestetica.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/depilclin/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName imagemproducoesrs.com.br
ServerAlias www.imagemproducoesrs.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/imagemproducoes/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName solangesiqueira.com.br
ServerAlias www.solangesiqueira.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/solange/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName sonicnm.com
ServerAlias www.sonicnm.com
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/sonicnm/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName muralhadachina.com
ServerAlias www.muralhadachina.com
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/muralhadachina/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName vetfarma.vet.br
ServerAlias www.vetfarma.vet.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/vetfarma/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName fisiocarvalho.com.br
ServerAlias www.fisiocarvalho.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/valeriacarvalho/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName gumafestas.com.br
ServerAlias www.gumafestas.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/gumafestas/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName leatherco.com.br
ServerAlias www.leatherco.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/lcmanufaturados/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName marciocastan.com.br
ServerAlias www.marciocastan.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/marciocastan/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName carolnovo.com.br
ServerAlias www.carolnovo.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/carolnovo/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName cleberandradas.com.br
ServerAlias www.cleberandradas.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/cleberoliveira/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName patriciafontoura.com.br
ServerAlias www.patriciafontoura.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/patriciavieira/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName ramirozilles.com.br
ServerAlias www.ramirozilles.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/ramirozilles/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName anaotton.com.br
ServerAlias www.anaotton.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/anaotton/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName manopereira.com
ServerAlias www.manopereira.com
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/manopereira/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName marcelobuz.com.br
ServerAlias www.marcelobuz.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/marcelobuz/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName jamesadv.com.br
ServerAlias www.jamesadv.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/jamessantos/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName filipejobim.com.br
ServerAlias www.filipejobim.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/filipejobim/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName alexgaspar.com.br
ServerAlias www.alexgaspar.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/alexgaspar/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName esteticaandreacosta.com.br
ServerAlias www.esteticaandreacosta.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/andreacosta/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName transportesmedeiros.com.br
ServerAlias www.transportesmedeiros.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/transportesmedeiros/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName mpcostaimoveis.com.br
ServerAlias www.mpcostaimoveis.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/mpcosta/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName neandaraimoveis.com.br
ServerAlias www.neandaraimoveis.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/neandaraimoveis/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName justburgersbrasil.com.br
ServerAlias www.justburgersbrasil.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/JustBurgers/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName clinicapargendler.com.br
ServerAlias www.clinicapargendler.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/mpargendler/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName versatillepersianas.com
ServerAlias www.versatillepersianas.com
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/versatille/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName guilhermeparanhos.com
ServerAlias www.guilhermeparanhos.com
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/guilhermeparanhos/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName lojatriunvirato.com.br
ServerAlias www.lojatriunvirato.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/triunvirato/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName ibveducacao.org.br
ServerAlias www.ibveducacao.org.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/ibve/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName bichobacanars.com.br
ServerAlias www.bichobacanars.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/bichobacana/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName colunacarvalho.com.br
ServerAlias www.colunacarvalho.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/colunacarvalho/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName seg-park.com
ServerAlias www.seg-park.com
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/segpark/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName estacaomais.net
ServerAlias www.estacaomais.net
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/estacaomais/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName flexfitroupas.com.br
ServerAlias www.flexfitroupas.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/flex/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName houseoflondon.com.br
ServerAlias www.houseoflondon.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/houseoflondon/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName eduardopaulitsch.com.br
ServerAlias www.eduardopaulitsch.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/eduardopaulitsch/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName sharbel.com.br
ServerAlias www.sharbel.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/sharbel/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName cesalveterinaria.com.br
ServerAlias www.cesalveterinaria.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/cesal/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName valentinesunglasses.com.br
ServerAlias www.valentinesunglasses.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/valentine/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName animaliaveterinaria.com.br
ServerAlias www.animaliaveterinaria.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/animaliaveterinaria/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName jorgeluis.com.br
ServerAlias www.jorgeluis.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/jorgeluis/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName jaquelinenoleto.com.br
ServerAlias www.jaquelinenoleto.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/noleto/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName coloproctopoa.com.br
ServerAlias www.coloproctopoa.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/dacunha/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName pauladazzi.com.br
ServerAlias www.pauladazzi.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/pazzi/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName nasimi.com.br
ServerAlias www.nasimi.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/rafaelveiga/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName mundoabstrato.com.br
ServerAlias www.mundoabstrato.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/cinthiamurray/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName ricardoconsultoria.com.br
ServerAlias www.ricardoconsultoria.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/ricardor/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName daybydayhair.com.br
ServerAlias www.daybydayhair.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/daybyday/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName multiartesmolduras.com.br
ServerAlias www.multiartesmolduras.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/multiartes/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName luanabarbosa.com
ServerAlias www.luanabarbosa.com
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/luanabarbosa/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName jappa.com.br
ServerAlias www.jappa.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/jappa/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName imagoestudio.com.br
ServerAlias www.imagoestudio.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/imago/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

