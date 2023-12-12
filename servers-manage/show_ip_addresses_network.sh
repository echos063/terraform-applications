#!/bin/bash

vm_list=$(virsh list --all --name)

for vm in $vm_list
do
  ip_address=$(virsh domifaddr $vm | grep ipv4 | awk '{print $4}')
  mac_address=$(virsh domiflist $vm | grep -o -E '([0-9a-fA-F]{2}:){5}([0-9a-fA-F]{2})')
  echo "VM: $vm, IP: $ip_address, MAC: $mac_address"
done