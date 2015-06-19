#include <stdio.h>

#include <vmnet/vmnet.h>

#include "uuid.h"

void vmnet_get_mac_address_from_uuid(char *guest_uuid_str);

int
main(int argc, char *argv[])
{
  if (argc < 2) {
    fprintf(stderr, "Usage: %s <UUID>\n", argv[0]);
    exit(1);
  }

  vmnet_get_mac_address_from_uuid(argv[1]);

  exit(0);
}

void
vmnet_get_mac_address_from_uuid(char *guest_uuid_str) {
  xpc_object_t interface_desc;
  uuid_t uuid;
  __block interface_ref iface;
  __block vmnet_return_t iface_status;
  dispatch_semaphore_t iface_created;
  dispatch_queue_t if_create_q;
  uint32_t uuid_status;

/*
 * from vmn_create
 */
  interface_desc = xpc_dictionary_create(NULL, NULL, 0);
  xpc_dictionary_set_uint64(interface_desc, vmnet_operation_mode_key, VMNET_SHARED_MODE);

  uuid_from_string(guest_uuid_str, &uuid, &uuid_status);
  if (uuid_status != uuid_s_ok) {
    fprintf(stderr, "Invalid UUID\n");
    exit(1);
  }

  xpc_dictionary_set_uuid(interface_desc, vmnet_interface_id_key, uuid);
  iface = NULL;
  iface_status = 0;

  if_create_q = dispatch_queue_create("org.xhyve.vmnet.create", DISPATCH_QUEUE_SERIAL);

  iface_created = dispatch_semaphore_create(0);

  iface = vmnet_start_interface(interface_desc, if_create_q,
    ^(vmnet_return_t status, xpc_object_t interface_param)
  {
    iface_status = status;
    if (status != VMNET_SUCCESS || !interface_param) {
      fprintf(stderr, "virtio_net: Could not create vmnet interface, "
        "permission denied or no entitlement?\n");
      dispatch_semaphore_signal(iface_created);
      return;
    }

    printf("%s\n", xpc_dictionary_get_string(interface_param, vmnet_mac_address_key));

    dispatch_semaphore_signal(iface_created);
  });

  dispatch_semaphore_wait(iface_created, DISPATCH_TIME_FOREVER);
  dispatch_release(if_create_q);
}
