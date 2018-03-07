# LotServer

## Install

```bash
# Prepare
apt-get update
apt-get install ethtool -y --no-install-recommends
mkdir -p /appex/bin /appex/etc
mkdir -p /tmp/lotserver

# Generate license
cd /tmp/lotserver
wget https://github.com/pexcn/LotServer/raw/master/crack/crack.sh && chmod +x crack.sh
bash crack.sh $(cat /sys/class/net/eth0/address) 2070 0
mv apx-*.lic /appex/etc/apx.lic
chattr +ai /appex/etc/apx.lic

# Install lotserver
wget -O /appex/bin/acce-3.11.20.10 https://github.com/pexcn/LotServer/raw/master/install/acce/<version>
chmod +x /appex/bin/acce-3.11.20.10
cp -f $(which ethtool) /appex/bin

# Setup install files
cd /tmp/lotserver
wget https://github.com/pexcn/LotServer/raw/master/install/lotserver.tar.gz
tar -zxvf lotserver.tar.gz
cd lotserver
bash install.sh

# Clean up
cd ~ && rm -r /tmp/lotserver
```

## Uninstall

```bash
# Uninstall
chattr -ai /appex/etc/apx.lic /appex/etc/config
/appex/bin/lotServer.sh uninstall

# Check files removed
find / -name "*appex*"
find / -name "*lotserver*"
find / -name "*lotServer*"
#find / -name "*LotServer*"
#find / -name "*serverspeeder*"
#find / -name "*serverSpeeder*"
#find / -name "*ServerSpeeder*"
```
