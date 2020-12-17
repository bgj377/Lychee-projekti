# Oma moduli: Palvelinten hallinta

Tällä sivustolla on kurssin "Palvelinten hallinta" harjoitustehtävä 7: "Oma moduli". Tehtävät on tehty XUbuntu 18.04.5 Desktop käyttöjärjestelmän avulla. Tehtävissä käytetyt komennot on annettu terminaali-ikkunassa.

Tein modulin, joka helpottaa Lychee-sovelluksen käyttöönottoa. Lychee on selainpohjainen kuvienhallinnan sovellus. Lycheen avulla koneella olevia kuvia voidaan hallita selaimen kautta.

Luodaan modulia varten kansio    
$ mkdir -p /srv/salt/lychee/

Luodaan moduli ja kirjoitetaan komennot  
$ sudoedit /srv/salt/lychee/init.sls

Ladataan paketit, jotka tarvitaan Lycheeta varten  
![paketit](https://github.com/bgj377/Lychee-projekti/blob/main/moduli-Kuvat/mo-paketit.JPG)
