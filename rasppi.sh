#!/bin/bash
apt-get update

echo "-------setting up audio"
amixer cset numid=3 1

echo "-------installing prereqs"
apt-get -y install git python libao-dev libssl-dev libcrypt-openssl-rsa-perl libio-socket inet6-perl libwww-perl avahi-utils
apt-get -y install build-essential libssl-dev libcrypt-openssl-rsa-perl libao-dev libio-socket-inet6-perl libwww-perl avahi-utils pkg-config
apt-get -y install subversion libjpeg8-dev imagemagick libav-tools
echo "-------installing pip"
apt-get -y install python-pip
cd /home/pi
echo "-------grabbing scripts"
git clone https://github.com/whisperoftheshot/raspi_scripts

echo "-------setting up perlnet sdp"
cd /home/pi
git clone https://github.com/njh/perl-net-sdp.git perl-net-sdp
cd perl-net-sdp
perl Build.PL
./Build
./Build test
./Build install
cd

echo "-------installing shairport"

cd /home/pi
git clone https://github.com/hendrikw82/shairport.git
cd shairport
make install
#./shairport.pl
cd /home/pi/raspi_scripts
cp shairport.init /etc/init.d/shairport
cd /etc/init.d
chmod a+x shairport
update-rc.d shairport start 99 2
#./shairport.pl start

#echo "-------install pianobar"
#apt-get -y install pianobar

echo "-------installing drivemount"
mkdir /media/movies
mkdir /media/music
mkdir /media/reprap
mkdir /media/playlists
cd /home/pi/raspi_scripts
chmod 755 mybookmount.sh
cp mybookmount.sh /etc/init.d
cd /etc/init.d
chmod 711 mybookmount.sh
update-rc.d mybookmount.sh start 99 2
#
echo "-------installing octoprint"
cd /home/pi
git clone https://github.com/foosel/OctoPrint.git
cd OctoPrint
pip install -r requirements.txt
cd /home/pi/raspi_scripts
chmod 755 octoprintstart.sh
cp octoprintstart.sh /etc/init.d
cd /etc/init.d
chmod 711 octoprintstart.sh
update-rc.d octoprintstart.sh start 99 2

#echo "webcam stuff"
#cd /home/pi
#wget -Omjpg-streamer.tar.gz http://mjpg-streamer.svn.sourceforge.net/viewvc/mjpg-streamer/mjpg-streamer/?view=tar
#tar xfz mjpg-streamer.tar.gz
#cd mjpg-streamer
#make
#./mjpg_streamer -i "./input_uvc.so" -o "./output_http.so"

#echo "-------installing owncloud"
#cd /home/pi
#git clone git://github.com/petrockblog/OwncloudPie.git
#cd OwncloudPie
#chmod +x owncloudpie_setup.sh
#./owncloudpie_setup.sh