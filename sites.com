 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName alexandre.com
ServerAlias www.alexandre.com
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/alexandre08/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName galvano.com.br
ServerAlias www.galvano.com.br
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
ServerName alinefisio.com.br
ServerAlias www.alinefisio.com.br
DocumentRoot /srv/www/celulaz.com.br/my-app/public/
<Directory /srv/www/celulaz.com.br/my-app/public/>
AllowOverride All
Order allow,deny
Allow from all
 </Directory>
DirectoryIndex sites/alinefisio/index.html
ErrorLog /srv/www/celulaz.com.br/logs/error.log
CustomLog /srv/www/celulaz.com.br/logs/access.log combined
</VirtualHost>

 <VirtualHost *>
ServerAdmin suporte@celulaz.com.br
ServerName alexluis.com.br
ServerAlias www.alexluis.com.br
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
ServerName triunvirato.com.br
ServerAlias www.triunvirato.com.br
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

