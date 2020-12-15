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

#käsin tehdessä apache2 täytyy asennuksen jälkeen bootata, joten tehdään sama
apache2:
  service.running:
    - refresh: True

#tämä tiedosto määrittää kuinka suuria tiedostoja voidaan ladata ja
#siinä on liian pienet oletusarvot, joten käytetään omaa tiedostoa, jossa
#arvot ovat tarpeeksi suuret
/etc/php/7.2/apache2/php.ini:
  file.managed:
    - source: salt://lychee/php.ini

#Konfigurointitiedosto Lycheehen linkittämistä varten
/etc/apache2/sites-available/lychee.conf:
  file.managed:
    - source: salt://lychee/lychee.conf

#asennetaan MySql
mysqlroot:
  debconf.set:
    - data:
        'mysql-server/root_password': {'type': 'password', 'value': 'mysqlpass'}
        'mysql-server/root_password_again': {'type': 'password', 'value': 'mysqlpass'}

#Asennetaan paketit, jotka tarvitaa MySql:n käyttöä varten
asenna_mysql_paketit:
  pkg.installed:
    - pkgs:
      - python3-mysqldb
      - python-pip
      - python-dev
      - mysql-server
      - mysql-client
      - libmysqlclient-dev

lychee:
  mysql_database.present

lycheeuser:
  mysql_user.present:
    - host: localhost
    - password: "mysqluser"

#Seuraavaa funktio antaisi käyttäjälle oikeudet mutta sitä, ei voinut ajaa bugin vuoksi

#lycheeuser_lycheedb:
#  mysql_grants.present:
#    - database: '*.*'
#    - user: lycheeuser
#    - host: localhost
#    - grant: all privileges
#    - grant_option: True
