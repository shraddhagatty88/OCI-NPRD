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

# Object Storage Namespace:
data "oci_objectstorage_namespace" "namespace" {
}

# Common Services State File:
data "terraform_remote_state" "common_services" {
  backend = "s3"

  config = {
    bucket                      = "ELFC-Terraform-States"
    key                         = "elfc-common-services.tfstate"
    region                      = "uk-london-1"
    endpoint                    = "https://lr2npxngbol0.compat.objectstorage.uk-london-1.oraclecloud.com"
    profile                     = "elfcoci"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}

data "oci_core_images" "custom_image_ol7_openscap" {
    compartment_id = data.terraform_remote_state.common_services.outputs.common_services_compartment_id
    display_name   = "V1-OL7-OpenSCAP-v1.0"
}

data "oci_core_images" "custom_image_v1-oel7-golden" {
    compartment_id = data.terraform_remote_state.common_services.outputs.common_services_compartment_id
    display_name   = "V1-OEL7-GoldenImage-100GB-20200430"
}

data "oci_core_volume_backup_policies" "silver_backup_policy" {
  filter {
    name   = "display_name"
    values = ["silver"]
  }
}

data "oci_core_volume_backup_policies" "gold_backup_policy" {
  filter {
    name   = "display_name"
    values = ["gold"]
  }
}

############################################################################