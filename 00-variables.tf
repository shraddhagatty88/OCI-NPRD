############################################################################
# Variables:
############################################################################

variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}

variable customer_label{
    default = ""
}


locals {
  compute_shapes = {
    e2-1  = "VM.Standard.E2.1"
    e2-2  = "VM.Standard.E2.2"
    e2-4  = "VM.Standard.E2.4"
    s2-1  = "VM.Standard2.1"
    s2-16  = "VM.Standard2.16"
    s2-2  = "VM.Standard2.2"
    s2-4  = "VM.Standard2.4"
    s2-8  = "VM.Standard2.8"
    
  }

}


locals {
  tags_common = {
    "Account.CompartmentName" = "common_services"
    "Account.StackName"       = var.StackName
    "Account.StackOwner"      = var.StackOwner
    "Account.ProjectName"     = var.ProjectName
    "Account.BillingOwner"    = var.BillingOwner
    "Billing.CostCentre"      = var.CostCenter
    "Billing.Workload"        = var.Workload
    "Billing.Environment"     = "Common"
  }

  tags_prd = {

    "Account.CompartmentName" = "production_services"
    "Account.StackName"       = var.StackName
    "Account.StackOwner"      = var.StackOwner
    "Account.ProjectName"     = var.ProjectName
    "Account.BillingOwner"    = var.BillingOwner
    "Billing.CostCentre"      = var.CostCenter
    "Billing.Workload"        = var.Workload
    "Billing.Environment"     = "Production"

  }

  tags_nprd = {

    "Account.CompartmentName" = "nonproduction_services"
    "Account.StackName"       = var.StackName
    "Account.StackOwner"      = var.StackOwner
    "Account.ProjectName"     = var.ProjectName
    "Account.BillingOwner"    = var.BillingOwner
    "Billing.CostCentre"      = var.CostCenter
    "Billing.Workload"        = var.Workload
    "Billing.Environment"     = "NonProduction"

  }

}

#Tags Name
variable "StackName" {
    default = ""
}
variable "StackOwner" {
    default = ""
}
variable "ProjectName" {
    default = ""
}
variable "BillingOwner" {
    default = ""
}
variable "CostCenter" {
    default = ""
}
variable "Workload" {
    default = ""
}


############################################################################

### DB Specific 

variable "character_set" {
  default = "WE8MSWIN1252"
}
variable "db_edition" {
  default = "STANDARD_EDITION"
}
variable "db_version" {
  default = "19.12.0.0"
}
variable "data_storage_size_in_gb" {
  default = 256
}
variable "db_workload" {
  default = "OLTP"
}

#########################################################################
### Compute Specific
variable "shape_ocpus" {
  default = 2
}
variable "shape_mem" {
  default = 16
}
variable "boot_volume_size_in_gbs" {
  
  default = 100
}
variable "backup_policy" {
  
  default = "silver"
}
