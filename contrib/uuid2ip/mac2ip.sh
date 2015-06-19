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

awk '{if ($1 == "}") ORS="\n"; else ORS=""; print}' /var/db/dhcpd_leases | \
  awk '/hw_address=1,'$MAC_ADDRESS'/ {print substr($3, 12)}'
