#!/bin/bash

if ! [[ "$(id -u)" == "0" ]]
then
  echo "This container must run as root user"
  exit 1
fi

# SPP Firmware
function updIlo() {
  if [[ $FORCE_UPDATE == true ]];then
    echo ""
    echo "###########################################"
    echo "FORCE Update Ilo firmware"
    echo "###########################################"
    echo ""
    /usr/lib/x86_64-linux-gnu/firmware-ilo5-3.09-1.1/hpsetup -f -s --tpmbypass
    cat /var/cpq/Component.log; rm -f /var/cpq/Component.log 
  else   
    echo ""
    echo "###########################################"
    echo "Update Ilo firmware"
    echo "###########################################"
    echo ""
    /usr/lib/x86_64-linux-gnu/firmware-ilo5-3.09-1.1/hpsetup -s --tpmbypass
    cat /var/cpq/Component.log; rm -f /var/cpq/Component.log
  fi
}
function updPowerPIC() {
  if [[ $FORCE_UPDATE == true ]];then
    echo ""
    echo "###########################################"
    echo "FORCE Update PowerPIC firmware"
    echo "###########################################"
    echo ""
    /usr/lib/x86_64-linux-gnu/firmware-powerpic-gen10-1.1.4-3.1/hpsetup -f -s --tpmbypass
    cat /var/cpq/Component.log; rm -f /var/cpq/Component.log 
  else   
    echo ""
    echo "###########################################"
    echo "Update PowerPIC firmware"
    echo "###########################################"
    echo ""
    /usr/lib/x86_64-linux-gnu/firmware-powerpic-gen10-1.1.4-3.1/hpsetup -s --tpmbypass
    cat /var/cpq/Component.log; rm -f /var/cpq/Component.log
  fi
}
function updSmartArray() {
  if [[ $FORCE_UPDATE == true ]];then
    echo ""
    echo "###########################################"
    echo "FORCE Update SmartArray firmware"
    echo "###########################################"
    echo ""
    /usr/lib/x86_64-linux-gnu/firmware-smartarray-f7c07bdbbd-7.11-1.1/hpsetup -f -s
    cat /var/cpq/Component.log; rm -f /var/cpq/Component.log 
  else   
    echo ""
    echo "###########################################"
    echo "Update SmartArray firmware"
    echo "###########################################"
    echo ""
    /usr/lib/x86_64-linux-gnu/firmware-smartarray-f7c07bdbbd-7.11-1.1/hpsetup -s
    cat /var/cpq/Component.log; rm -f /var/cpq/Component.log
  fi
}
function updIE() {
  if [[ $FORCE_UPDATE == true ]];then
    echo ""
    echo "###########################################"
    echo "FORCE Update IE firmware"
    echo "###########################################"
    echo ""
    /usr/lib/x86_64-linux-gnu/firmware-iegen10-0.2.3.0-5.1/hpsetup -f -s --tpmbypass
    cat /var/cpq/Component.log; rm -f /var/cpq/Component.log 
  else   
    echo ""
    echo "###########################################"
    echo "Update IE firmware"
    echo "###########################################"
    echo ""
    /usr/lib/x86_64-linux-gnu/firmware-iegen10-0.2.3.0-5.1/hpsetup -s --tpmbypass
    cat /var/cpq/Component.log; rm -f /var/cpq/Component.log
  fi
}
function updSPS() {
  if [[ $FORCE_UPDATE == true ]];then
    echo ""
    echo "###########################################"
    echo "FORCE Update SPS firmware"
    echo "###########################################"
    echo ""
    /usr/lib/x86_64-linux-gnu/firmware-spsgen10-04.01.05.002-2.1/hpsetup -f -s --tpmbypass
    cat /var/cpq/Component.log; rm -f /var/cpq/Component.log 
  else   
    echo ""
    echo "###########################################"
    echo "Update SPS firmware"
    echo "###########################################"
    echo ""
    /usr/lib/x86_64-linux-gnu/firmware-spsgen10-04.01.05.002-2.1/hpsetup -s --tpmbypass
    cat /var/cpq/Component.log; rm -f /var/cpq/Component.log
  fi
}
function updBIOS() {
  if [[ $FORCE_UPDATE == true ]];then
    echo ""
    echo "###########################################"
    echo "FORCE Update BIOS firmware"
    echo "###########################################"
    echo ""
    /usr/lib/x86_64-linux-gnu/firmware-system-u32-3.30_2024_07_31-1.1/hpsetup -f -s --tpmbypass
    cat /var/cpq/Component.log; rm -f /var/cpq/Component.log 
  else   
    echo ""
    echo "###########################################"
    echo "Update BIOS firmware"
    echo "###########################################"
    echo ""
    /usr/lib/x86_64-linux-gnu/firmware-system-u32-3.30_2024_07_31-1.1/hpsetup -s --tpmbypass
    cat /var/cpq/Component.log; rm -f /var/cpq/Component.log
  fi
}
function updIntelNIC() {
  if [[ $FORCE_UPDATE == true ]];then
    echo ""
    echo "###########################################"
    echo "FORCE Update IntelNIC firmware"
    echo "###########################################"
    echo ""
    /usr/lib/x86_64-linux-gnu/firmware-nic-is-intel-1.31.0-1.1/hpsetup -f -s
    cat /var/cpq/Component.log; rm -f /var/cpq/Component.log 
  else   
    echo ""
    echo "###########################################"
    echo "Update IntelNIC firmware"
    echo "###########################################"
    echo ""
    /usr/lib/x86_64-linux-gnu/firmware-nic-is-intel-1.31.0-1.1/hpsetup -s
    cat /var/cpq/Component.log; rm -f /var/cpq/Component.log
  fi
}
function updBroadNIC() {
  if [[ $FORCE_UPDATE == true ]];then
    echo ""
    echo "###########################################"
    echo "FORCE Update BroadNIC firmware"
    echo "###########################################"
    echo ""
    /usr/lib/x86_64-linux-gnu/firmware-nic-bcm-2.38.0-1.1/hpsetup -f -s
    cat /var/cpq/Component.log; rm -f /var/cpq/Component.log 
  else   
    echo ""
    echo "###########################################"
    echo "Update BroadNIC firmware"
    echo "###########################################"
    echo ""
    /usr/lib/x86_64-linux-gnu/firmware-nic-bcm-2.38.0-1.1/hpsetup -s
    cat /var/cpq/Component.log; rm -f /var/cpq/Component.log
  fi
}

function updXXV710() {
  echo ""
  echo "###########################################"
  echo "Update Intel XXV710 firmware"
  echo "###########################################"
  echo "Note: this firmware installer runs unconditionally and takes no action if the firmware is already up-to-date."
  cd /opt/hpefwupdate/Linux_x64/
  /opt/hpefwupdate/Linux_x64/nvmupdate64e -u -l -c /opt/hpefwupdate/Linux_x64/nvmupdate.cfg
}

function updMLXC5() {
  echo ""
  echo "###########################################"
  echo "Update Mellanox MLXC5 firmware"
  echo "###########################################"
  echo "Note: this firmware installer runs unconditionally and takes no action if the firmware is already up-to-date."
  /usr/lib/x86_64-linux-gnu/firmware-nic-mellanox-641sfp28-private-16.35.3502-1.1/hpsetup -f -s
}

### MAIN ###
echo "Start firmware updates."
rm -f /var/cpq/Component.log
if [[ $COMPONENT == "ilo" ]];then
  updIlo
elif [[ $COMPONENT == "powerPIC" ]];then
  updPowerPIC
elif [[ $COMPONENT == "smartArray" ]];then
  updSmartArray
elif [[ $COMPONENT == "innovationEngine" ]];then
  updIE
elif [[ $COMPONENT == "sps" ]];then
  updSPS
elif [[ $COMPONENT == "bios" ]];then
  updBIOS
elif [[ $COMPONENT == "nic" ]];then
  updIntelNIC
  updBroadNIC
  updXXV710NIC
  updMLXC5
else
  updIlo
  updPowerPIC
  updSmartArray
  updIE
  updSPS
  updBIOS
  updIntelNIC
  updBroadNIC
  updXXV710NIC
  updMLXC5
fi
echo
echo "Done running firmware updates."
exit 0
