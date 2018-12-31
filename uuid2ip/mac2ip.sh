#!/bin/sh

print_usage() {
  echo "Usage: $(basename $0) <mac_address>"
}

MAC_ADDRESS="$1"
if [ -z "$MAC_ADDRESS" ] ; then
  print_usage >&2
  exit 1
fi
shift

awk '
{
  if ($1 ~ /^ip_address/) {
    ip_address=substr($1, 12)
  }
  if ($1 ~ /^hw_address/) {
    hw_address=substr($1, 14)
    split(hw_address, a, ":")
    hw_address=sprintf("%02s:%02s:%02s:%02s:%02s:%02s", a[1], a[2], a[3], a[4], a[5], a[6])
  }
  if (hw_address != "" && ip_address != "") {
    ip_addresses[hw_address]=ip_address
    hw_address=ip_address=""
  }
}
END {
  print ip_addresses["'$MAC_ADDRESS'"]
}
' /var/db/dhcpd_leases
