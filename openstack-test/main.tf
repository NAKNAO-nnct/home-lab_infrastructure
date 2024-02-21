provider "esxi" {
  esxi_hostname = var.esxi_hostname
  esxi_username = var.esxi_username
  esxi_password = var.esxi_password
}

locals {
  ovf_source      = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.ova"
  guest_num_vcpu  = 8
  guest_memory_gb = 8
  guest_disk_gb   = 30
}

resource "esxi_guest" "openstackcontroller" {
  ovf_source = local.ovf_source
  guestos    = "ubuntu-64"

  virthwver = "21"

  boot_firmware = "efi"

  guest_name = "openstackcontroller"
  power      = "on"

  numvcpus       = local.guest_num_vcpu
  memsize        = max(local.guest_memory_gb * 1024, 512)
  disk_store     = "WD_HDD_2000_datastore"
  boot_disk_size = max(local.guest_disk_gb, 20)
  
  network_interfaces {
      virtual_network = "VM Network"
  }

  network_interfaces {
      virtual_network = "openstack-manegment"
  }

  network_interfaces {
    virtual_network = "openstack-internal"
  }

  guestinfo = {
    "userdata"          = base64gzip(file("./cloud-init.yml"))
    "userdata.encoding" = "gzip+base64"
    "metadata"          = base64gzip(file("./meta.yml"))
    "metadata.encoding" = "gzip+base64"
  }
}

resource "esxi_guest" "openstackworker1" {
  ovf_source = local.ovf_source
  guestos    = "ubuntu-64"

  virthwver = "21"

  boot_firmware = "efi"

  guest_name = "openstackworker1"
  power      = "on"

  numvcpus       = local.guest_num_vcpu
  memsize        = max(local.guest_memory_gb * 1024, 512)
  disk_store     = "WD_HDD_2000_datastore"
  boot_disk_size = max(local.guest_disk_gb, 20)
  
  network_interfaces {
      virtual_network = "VM Network"
  }

  network_interfaces {
      virtual_network = "openstack-manegment"
  }

  network_interfaces {
    virtual_network = "openstack-internal"
  }

  guestinfo = {
    "userdata"          = base64gzip(file("./cloud-init.yml"))
    "userdata.encoding" = "gzip+base64"
    "metadata"          = base64gzip(file("./meta1.yml"))
    "metadata.encoding" = "gzip+base64"
  }
}

resource "esxi_guest" "openstackworker2" {
  ovf_source = local.ovf_source
  guestos    = "ubuntu-64"

  virthwver = "21"

  boot_firmware = "efi"

  guest_name = "openstackworker2"
  power      = "on"

  numvcpus       = local.guest_num_vcpu
  memsize        = max(local.guest_memory_gb * 1024, 512)
  disk_store     = "WD_HDD_2000_datastore"
  boot_disk_size = max(local.guest_disk_gb, 20)

  network_interfaces {
      virtual_network = "VM Network"
  }

  network_interfaces {
      virtual_network = "openstack-manegment"
  }

  network_interfaces {
    virtual_network = "openstack-internal"
  }

  guestinfo = {
    "userdata"          = base64gzip(file("./cloud-init.yml"))
    "userdata.encoding" = "gzip+base64"
    "metadata"          = base64gzip(file("./meta2.yml"))
    "metadata.encoding" = "gzip+base64"
  }
}

