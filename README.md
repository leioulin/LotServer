# LotServer

**WARNING: THIS REPO FOR LEARNING AND COMMUNICATION ONLY!**

## Install

```bash
# prepare environment
apt-get update
apt-get install git ethtool -y --no-install-recommends

mkdir -p /appex/bin /appex/etc
cp -f $(which ethtool) /appex/bin
git clone https://github.com/pexcn/LotServer.git --depth 1 && cd LotServer

# generate license
pushd crack
bash crack.sh $(cat /sys/class/net/eth0/address) 2070 0
mv apx-*.lic /appex/etc/apx.lic
chattr +ai /appex/etc/apx.lic
popd

# install lotserver
cp install/acce/<path/to/version> /appex/bin/acce-3.11.20.10
#cp install/acce/Debian/8/3.16.0-4-amd64/x64/3.11.20.10/acce /appex/bin/acce-3.11.20.10
chmod +x /appex/bin/acce-3.11.20.10

# setup install files
pushd install/lotserver
bash install.sh
popd

# clean
cd .. && rm -r LotServer
```

## Uninstall

```bash
# uninstall
chattr -ai /appex/etc/apx.lic /appex/etc/config
/appex/bin/lotServer.sh uninstall -f

# check files removed
find / -iname "*appex*"
find / -iname "*lotserver*"
find / -iname "*serverspeeder*"
```
