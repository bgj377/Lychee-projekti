# Oma moduli: Palvelinten hallinta

Tällä sivustolla on kurssin "Palvelinten hallinta" harjoitustehtävä 7: "Oma moduli". Tehtävät on tehty XUbuntu 18.04.5 Desktop käyttöjärjestelmän avulla. Tehtävissä käytetyt komennot on annettu terminaali-ikkunassa.

Tein modulin, joka helpottaa Lychee-sovelluksen käyttöönottoa. Lychee on selainpohjainen kuvienhallinnan sovellus. Lycheen avulla koneella olevia kuvia voidaan hallita selaimen kautta.

Luodaan modulia varten kansio    
$ mkdir -p /srv/salt/lychee/

Luodaan moduli ja kirjoitetaan komennot  
$ sudoedit /srv/salt/lychee/init.sls

Ladataan paketit, jotka tarvitaan Lycheeta varten

![paketit](https://github.com/bgj377/Lychee-projekti/blob/main/moduli-Kuvat/mo-paketit.JPG)

Yksi Lycheen kannalta tärkeä tiedosto on php.ini. Se on konfigurointitiedosto, joka määrittelee rajat miten suuria tiedostoja voidaan ladata MySql:n. php.ini määrittelee, mikä on siirrettävän tiedoston maksimikoko ja kuinka paljon dataa pystytään siirtämään yhdellä kertaa. Oletusarvona olevat rajat on niin pieniä, että normaalikokoisia valokuvia ei pystyisi siirtämään. Sen vuoksi tein käsin php.ini tiedoston, jossa on tarpeeksi suuret raja-arvot ja laitoin sen ohittamaan asennuksen mukana tulevan tiedoston.

![phpini](https://github.com/bgj377/Lychee-projekti/blob/main/moduli-Kuvat/mo-php-ini.JPG)

Lycheeta varten tarvitaan konfigurointitiedosto lychee.conf, joka sisältää seuraavat tiedot

![lyconf](https://github.com/bgj377/Lychee-projekti/blob/main/moduli-Kuvat/mo-lychee-conf.JPG)

Laitetaan tiedosto viittaamaan apache2:n sites-available kansioon

![conf](https://github.com/bgj377/Lychee-projekti/blob/main/moduli-Kuvat/mo-lychee-tila.JPG)

Valitaan root-salasana MySql:n ja asennetaan MySql-paketit

![mysql](https://github.com/bgj377/Lychee-projekti/blob/main/moduli-Kuvat/mo-mysql-root-2.JPG)

Tarkoituksena oli tähän tilaan vielä mahduttaa komennot, joilla luodaan MySql:n tietokanta, tietokannalle käyttäjä ja antaa käyttäjälle oikeudet tietokantaan. 

![permi](https://github.com/bgj377/Lychee-projekti/blob/main/moduli-Kuvat/mo-oikeudet.JPG)

Tämä ei kuitenkaan onnistunut, koska Ubuntun Saltissa on jokin raportoitu TypeError bugi. Jos koettaisin ajaa nämä osuudet, niin saisin vain virheilmoituksia. Alla kuvaus bugista.

![bugi](https://github.com/bgj377/Lychee-projekti/blob/main/moduli-Kuvat/mo-bugi-kuva.JPG)

Tietokanta, käyttäjä ja käyttäjän käyttöoikeudet pitää siis tehdä käsin seuraavasti.  
$ sudo mysql -u root -p  
CREATE DATABASE lychee;  
CREATE USER ’lycheeuser’@’localhost’ IDENTIFIED BY ’*’;  
GRANT ALL PRIVILEGES ON lychee. * TO ‘lycheeuser’@’localhost’ WITH GRANT OPTION;  
flush privileges;  
exit;

Seuraavaksi Bridget-adapter täytyy laittaa päälle, jotta koneella on IP-osoite, jota muu maailma voi käyttää. Haetaan IP-osoite  

![iposoite](https://github.com/bgj377/Lychee-projekti/blob/main/moduli-Kuvat/mo-iposoite.JPG)

Lycheeta voidaan alkaa alustamaan kirjoittamalla "ip-osoite/Lychee" selaimen osoitekenttään.

## Lähteet

[http://terokarvinen.com/2018/salt-quickstart-salt-stack-master-and-slave-on-ubuntu-linux/](http://terokarvinen.com/2018/salt-quickstart-salt-stack-master-and-slave-on-ubuntu-linux/)

[https://terokarvinen.com/2018/mysql-automatic-install-with-salt-preseed-database-root-password/index.html](https://terokarvinen.com/2018/mysql-automatic-install-with-salt-preseed-database-root-password/index.html)

[https://docs.saltstack.com/en/3000/ref/states/all/salt.states.mysql_database.html](https://docs.saltstack.com/en/3000/ref/states/all/salt.states.mysql_database.html)

[https://docs.saltstack.com/en/3000/ref/states/all/salt.states.mysql_user.html](https://docs.saltstack.com/en/3000/ref/states/all/salt.states.mysql_user.html)  

[https://docs.saltstack.com/en/3000/ref/states/all/salt.states.mysql_grants.html](https://docs.saltstack.com/en/3000/ref/states/all/salt.states.mysql_grants.html)

[https://www.digitalocean.com/community/tutorials/saltstack-infrastructure-creating-salt-states-for-mysql-database-servers](https://www.digitalocean.com/community/tutorials/saltstack-infrastructure-creating-salt-states-for-mysql-database-servers)

[https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-ubuntu-18-04](https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-ubuntu-18-04)

[https://github.com/saltstack/salt/issues/45026](https://github.com/saltstack/salt/issues/45026)

[https://bugs.launchpad.net/ubuntu/+source/salt/+bug/1823364](https://bugs.launchpad.net/ubuntu/+source/salt/+bug/1823364)

