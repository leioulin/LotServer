#!/bin/bash

if [ $# -lt 3 ]
then
  echo -ne "Usage: bash $0 <mac> <expire_year> <bandwidth>\n\nbandwidth=0 means unlimited.\n"
  exit -1
fi

APX_LIC_TPL="b226bc274e220f53e22d863a1ec913dea6961bd046d034e88818e68d260d781345298b8d3b11e00b5061045667c12af4982992ab86ee7a4f84c1ef83020a1adc[serial]c81cb3b404eab69f59993fbf62bd373a[date]0663cea3f326[bw]a366445113ecf74205e40af32cb30c5342cc5ebd981f7e02a9326f3823e8304e4d20f942f20bdfbeaeeff843"
APX_DATE_BASE=16245
APX_BW_BASE=3812869942
APX_MAC=$1
APX_DATE=$2
APX_BW=$3

APX_MAC=(${APX_MAC//:/ })
for (( i = 0; i < 16; i ++ ))
do
  if [ $i -lt 6 ]
  then
    APX_MAC_RES[$i]=`expr $((16#${APX_MAC[$i]})) + $i`
  else
    APX_MAC_RES[$i]=`expr ${APX_MAC_RES[$i%6]} + $i`
  fi
done

APX_SERIAL=""
for (( i = 0; i < 8; i ++ )) 
do
  _APX_TMP=`expr \( ${APX_MAC_RES[$i]}  + ${APX_MAC_RES[$i+8]} \) % 256`
  APX_SERIAL="${APX_SERIAL}"`printf "%02X" ${_APX_TMP}`
done

echo "SerialNo: ${APX_SERIAL}"

APX_RD=(162 15 239 202 57 14 45 164 147 232 120 90 117 15 239 232)
for (( i = 0; i < 16; i ++ ))
do
  _APX_TMP=`printf "%d" "'${APX_SERIAL:$i:1}"`
  _APX_TMP=`expr \( ${_APX_TMP} + ${APX_RD[$i]} \) % 256`
  APX_LIC="${APX_LIC}"`printf "%02x" ${_APX_TMP}`
done

echo "Licence: ${APX_LIC}"

APX_DATE_LIC=`expr ${APX_DATE_BASE} + ${APX_DATE}`
APX_DATE_LIC=`echo "${APX_DATE_LIC}"|perl -pe 'chomp;$_=unpack("H*",pack('v',$_))'`
#echo ${APX_DATE_LIC}

APX_BW_LIC=`expr ${APX_BW_BASE} + ${APX_BW}`
APX_BW_LIC=`echo "${APX_BW_LIC}"|perl -pe 'chomp;$_=unpack("H*",pack('V',$_))'`
#echo ${APX_BW_LIC}

APX_LIC=${APX_LIC_TPL//\[serial\]/$APX_LIC}
APX_LIC=${APX_LIC//\[date\]/$APX_DATE_LIC}
APX_LIC=${APX_LIC//\[bw\]/$APX_BW_LIC}
#echo $APX_LIC

echo "${APX_LIC}" | perl -pe 'chomp;$_=pack("H*",$_)' > apx-$2.lic
echo "License File Saved At: apx-$2.lic"
