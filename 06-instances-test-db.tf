############################################################################
# TEST Database:
############################################################################

module "instance-test-db" {
  source                         = "./modules/db-system"
  availability_domain            = var.availablity_domain_name2
  compartment_id                 = var.compartment_ocid
  subnet_id                      = var.subnet_ocid
  db_edition                     = var.db_edition
  character_set                  = var.character_set
  db_workload                    = var.db_workload
  db_ncharacter_set              = "AL16UTF16"
  db_name                        = "${var.customer_label}dbt"
  db_pdb_name                    = "${var.customer_label}test"
  db_version                     = var.db_version
  db_shape                       = var.db_shape
  ssh_public_keys                = var.ssh_key_nonprod
  data_storage_size_in_gb        = var.data_storage_size_in_gb
  hostname                       = "${var.customer_label}testdb"
  display_name                   = "${var.customer_label}testdb"
  defined_tags                   = local.tags_nprd
 # network_sec_groups             = [data.terraform_remote_state.common_services.outputs.security_group_nonprod_db_id
 #                      ,data.terraform_remote_state.common_services.outputs.security_group_nonprod_common_id
 #                                ]
}  

