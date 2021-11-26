############################################################################
# Providers:
############################################################################

provider "oci" {
  region           = var.region
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
}

############################################################################
# Home Provider (for Identity Resources):

provider "oci" {
  alias            = "home"
  region           = data.oci_identity_regions.home-region.regions[0]["name"]
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
}

############################################################################