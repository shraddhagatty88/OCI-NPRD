############################################################################
# Data Sources:
############################################################################

# Tenancy:
data "oci_identity_tenancy" "tenancy" {
  tenancy_id = var.tenancy_ocid
}

# Tenancy Home Region:
data "oci_identity_regions" "home-region" {
  filter {
    name   = "key"
    values = [data.oci_identity_tenancy.tenancy.home_region_key]
  }
}

# Tenancy Availability Domains:
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

# Object Storage Services:
data "oci_core_services" "core_services" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}

/*
data "oci_core_images" "custom_image_v1-oel7-golden" {
    compartment_id = data.terraform_remote_state.common_services.outputs.common_services_compartment_id
    display_name   = "V1-OEL7-GoldenImage-100GB-20200430"
}

#NSG
data "oci_core_network_security_group" "test_network_security_group" {
	#Required
	network_security_group_id = oci_core_network_security_group.test_network_security_group.id

  compartment_id = var.subnet_compartment
}
*/

data "oci_core_images" "OSImage" {
  compartment_id           = var.compartment_ocid
  operating_system         = var.instance_os
  operating_system_version = var.linux_os_version
  shape                    = var.Shape

  filter {
    name   = "display_name"
    values = ["^.*Oracle[^G]*$"]
    regex  = true
  }
}