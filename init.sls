asennapaketit:
  pkg.installed:
    - pkgs:
      - apache2
      - php
      - libapache2-mod-php
      - php-mysql
      - php-cli
      - php-gd
      - php-mysqlnd
      - php-curl
      - php-json
      - php-zip
      - php-exif
      - php-mbstring
      - debconf-utils

#tämä tiedosto määrittää kuinka suuria tiedostoja voidaan ladata ja
#siinä on liian pienet oletusarvot, joten käytetään omaa tiedostoa, jossa
#arvot ovat tarpeeksi suuret
/etc/php/7.2/apache2/php.ini:
  file.managed:
    - source: salt://lychee/php.ini

#Lycheen konfigurointitiedosto
/etc/apache2/sites-available/lychee.conf:
  file.managed:
    - source: salt://lychee/lychee.conf

#Valitaan salasana MySql:n
mysqlroot:
  debconf.set:
    - data:
        'mysql-server/root_password': {'type': 'password', 'value': 'mysqlpass'}
        'mysql-server/root_password_again': {'type': 'password', 'value': 'mysqlpass'}

#Asennetaan paketit, jotka tarvitaa MySql:n käyttöä varten
asenna_mysql_paketit:
  pkg.installed:
    - pkgs:
      - mysql-server
      - mysql-client
      - libmysqlclient-dev
#      - python3-mysqldb
#      - python-pip
#      - python-dev

#Seuraavilla komennoilla olisi luotu MySql:n tietokanta, tietokannan käyttäjä ja annettu oikeudet käyttäjälle,
#mutta bugin vuoksi se ei onnistu, kaikki tämä on tehtävä käsin.

#lychee:
#  mysql_database.present

#lycheeuser:
#  mysql_user.present:
#    - host: localhost
#    - password: "mysqluser"

#lycheeuser_lycheedb:
#  mysql_grants.present:
#    - database: '*.*'
#    - user: lycheeuser
#    - host: localhost
#    - grant: all privileges
#    - grant_option: True
