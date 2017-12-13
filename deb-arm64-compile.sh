sudo apt install fakeroot git kernel-wedge quilt ccache crossbuild-essential-arm64

mkdir ~/build-kernel
cd ~/build-kernel
wget http://ftp.iinet.net.au/debian/debian/pool/main/l/linux/linux_4.13.4.orig.tar.xz

git clone -n https://anonscm.debian.org/git/kernel/linux.git debian-kernel
cd debian-kernel
git checkout -b buster debian/4.13.4-2

export $(dpkg-architecture -aarm64)
export PATH=/usr/lib/ccache:$PATH
export DEB_BUILD_PROFILES="nopython nodoc pkg.linux.notools"
export MAKEFLAGS="-j$(($(nproc)*2))"

fakeroot make -f debian/rules clean
fakeroot make -f debian/rules orig
fakeroot make -f debian/rules source

echo CONFIG_BRCMFMAC_SDIO=y >> debian/config/arm64/config

fakeroot make -f debian/rules.gen setup_arm64
fakeroot make -f debian/rules.gen binary-arch_arm64
