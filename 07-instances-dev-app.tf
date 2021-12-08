############################################################################
# DEV App:
############################################################################
module "instance_dev_app" {
  source              = "./modules/core_instance"
  tenancy_id          = var.tenancy_ocid
  display_name        = "${var.customer_label}_dev_app"
  vnic_hostname_label = "${var.customer_label}-dev-app"
  shape               = var.instance_shape
  shape_ocpus         = var.shape_ocpus
  shape_mem           = var.shape_mem
  availability_domain = var.availablity_domain_name
  fault_domain        = 1
  compartment_id      = var.compartment_ocid
  subnet_id           = var.subnet_ocid1
  network_sec_groups  = local.nsg
  ssh_authorized_keys = var.ssh_key_nonprod
  source_id           = data.oci_core_images.OSImage.images[0].id
  source_type         = "bootVolume"
  boot_volume_size_in_gbs = 100
  assign_public_ip    = false
  boot_backup_policy  = "silver"
  #private_ip          = [var.instances_ip["dev_app"]]
  defined_tags        = local.tags_nprd                                      
  
}

############################################################################
#VG01

module "instance_dev_app_volume_VG01" {
  source              = "./modules/core_volume"
  tenancy_id          = var.tenancy_ocid
  volume_display_name = "${var.customer_label}_dev_app_VG01"
  availability_domain = module.instance_dev_app.core_instance_ad[0]
  compartment_id      = module.instance_dev_app.core_instance_compartment[0]
  backup_policy       = var.backup_policy
  size_in_gbs         = 100
  defined_tags        = local.tags_nprd
  
}

resource "oci_core_volume_attachment" "instance_dev_app_volume_attachment_VG01" {
  instance_id     = module.instance_dev_app.core_instance_ids[0]
  volume_id       = module.instance_dev_app_volume_VG01.core_volume_ids[0]
  device          = "/dev/oracleoci/oraclevdb"
  attachment_type = "paravirtualized"
}