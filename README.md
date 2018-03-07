# LotServer

## Install

```bash
# Prepare
apt-get update
apt-get install ethtool -y --no-install-recommends
mkdir -p /tmp/lotserver
cd /tmp/lotserver

# Install lotserver
wget https://github.com/pexcn/LotServer/raw/master/install/lotserver.tar.gz
tar -zxvf lotserver.tar.gz
cd lotserver
bash install.sh

# Install acce
wget -O /appex/bin/acce-3.11.20.10 https://github.com/pexcn/LotServer/raw/master/install/acce/<PATH/TO/ACCE/VERSION>

# Copy ethtool
cp -f $(which ethtool) /appex/bin

# Generate license

```
