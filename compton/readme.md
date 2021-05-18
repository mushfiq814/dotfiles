# Compton Compiling

[Instructions](https://github.com/tryone144/compton/blob/dual_kawase/README.md#how-to-build)

## Install Dependencies
```bash
sudo apt-get install build-essential libdbus-glib-1-dev libgirepository1.0-dev freeglut3-dev asciidoc libconfig-dev libdmx-dev libdrm-common libdrm-dev libxcomposite-dev libxdamage-dev libxrender-dev libxinerama-dev libxrandr-dev x11proto-xinerama-dev
```

## Build from Source
```bash
cd /tmp
git clone https://github.com/tryone144/compton
cd compton
make
make docs
make install
cd ..
rm -rf compton
```
