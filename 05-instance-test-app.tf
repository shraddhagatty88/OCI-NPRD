############################################################################
# TEST App:
############################################################################

module "instance_test_app" {
  source              = "./modules/core_instance"
  tenancy_id          = var.tenancy_ocid
  display_name        = "${var.customer_label}_test_app"
  vnic_hostname_label = "${var.customer_label}-test-app"
  shape               = var.instance_shape
  shape_ocpus         = var.shape_ocpus
  shape_mem           = var.shape_mem
  availability_domain = var.availablity_domain_name
  fault_domain        = 1
  compartment_id      = var.compartment_ocid
  subnet_id           = var.subnet_ocid
  network_sec_groups  = [data.terraform_remote_state.common_services.outputs.security_group_nonprod_app_id
                        ,data.terraform_remote_state.common_services.outputs.security_group_nonprod_common_id
                    #    ,data.terraform_remote_state.common_services.outputs.security_group_v1_vpn_id
                    ]
  ssh_authorized_keys = var.ssh_key_nonprod
  source_id           = data.oci_core_images.custom_image_v1-oel7-golden.images[0].id
  boot_volume_size_in_gbs = 100
  assign_public_ip    = false
  boot_backup_policy  = "silver"
  private_ip          = var.computeip
  defined_tags        = local.tags_nprd
  }

############################################################################
#VG01

module "instance_test_app_volume_VG01" {
  source              = "./modules/core_volume"
  tenancy_id          = var.tenancy_ocid
  volume_display_name = "${var.customer_label}_test_app_VG01"
  availability_domain = var.availablity_domain_name
  compartment_id      = var.compartment_ocid
  backup_policy       = var.backup_policy
  size_in_gbs         = 100
  defined_tags        = local.tags_nprd
  # source_details = {
  #   source_id    = data.oci_core_volume_backups.instance_nprd_app_VG01_backup.volume_backups.0.id
  #   source_type  = "volumeBackup" 
  # }
}

resource "oci_core_volume_attachment" "instance_test_app_volume_attachment_VG01" {
  instance_id     = module.instance_test_app.core_instance_ids[0]
  volume_id       = module.instance_test_app_volume_VG01.core_volume_ids[0]
  device          = "/dev/oracleoci/oraclevdb"
  attachment_type = "paravirtualized"
}

