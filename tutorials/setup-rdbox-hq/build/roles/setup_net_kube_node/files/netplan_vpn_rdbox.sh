#!/bin/bash

source /home/${SUDO_USER}/.bashrc.rdbox-hq

#
FILE_DHCLIENT_CONF="/etc/dhcp/dhclient.conf"
if [ ! -e "${FILE_DHCLIENT_CONF}.orig" ] ; then
    cp -p "${FILE_DHCLIENT_CONF}" "${FILE_DHCLIENT_CONF}.orig"
fi
sed -i -e "s/domain-name, domain-name-servers, domain-search, host-name,/domain-name, domain-search, host-name,/" ${FILE_DHCLIENT_CONF}

# IP address for vpnserver
cat << EOS_RDBOX > /etc/netplan/50-cloud-init.rdbox.yaml
        vpn_rdbox:
            dhcp4: yes
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
