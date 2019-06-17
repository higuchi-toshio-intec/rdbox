#!/bin/bash

source /home/${SUDO_USER}/.bashrc.rdbox-hq

# IP address for vpnserver
ADDRESS_VPN_RDBOX=`ipcalc ${RDBOX_NET_ADRS_VPNSERVER} ${RDBOX_NET_SUBNETMASK} | grep -i network | sed -e 's#  *# #g' | cut -f 2 -d ' '`
cat << EOS_RDBOX > /etc/netplan/50-cloud-init.rdbox.yaml
        vpn_rdbox:
            addresses:
            - ${ADDRESS_VPN_RDBOX}
    version: 2
EOS_RDBOX

#
FILE_NETPLAN_CLOUD_INIT=/etc/netplan/50-cloud-init.yaml 
if [ ! -e "${FILE_NETPLAN_CLOUD_INIT}.orig" ] ; then
    cp "${FILE_NETPLAN_CLOUD_INIT}" "${FILE_NETPLAN_CLOUD_INIT}.orig" 
fi
grep -v 'version' "${FILE_NETPLAN_CLOUD_INIT}.orig" >  "${FILE_NETPLAN_CLOUD_INIT}"
cat /etc/netplan/50-cloud-init.rdbox.yaml           >> "${FILE_NETPLAN_CLOUD_INIT}"

#
