# Lexit

[![Circle CI](https://circleci.com/gh/SLP-KBIT/Lexit.svg?style=shield)](https://circleci.com/gh/SLP-KBIT/Lexit)

* Requires

```
sudo apt-get install unoconv
sudo apt-get install imagemagick
sudo apt-get install xpdf
```

Office conversion requires:
```
sudo apt-get install xvfb

export DISPLAY=:1.0
Xvfb :1 &

sudo apt-get install ttf-mscorefonts-installer
sudo apt-get install fonts-vlgothic
sudo apt-get install fonts-mplus
sudo apt-get install fonts-migmix
wget "http://downloads.sourceforge.net/project/openofficeorg.mirror/4.1.1/binaries/ja/Apache_OpenOffice_4.1.1_Linux_x86-64_install-deb_ja.tar.gz"
tar xvfz Apache_OpenOffice_4.1.1_Linux_x86-64_install-deb_ja.tar.gz
cd ja/DEBS
sudo dpkg -i *.deb
unoconv --listener &
```
