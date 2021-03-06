############################################################################
# Variables:
############################################################################

variable "tenancy_ocid" {}
#variable "user_ocid" {}
#variable "fingerprint" {}
#variable "private_key_path" {}
variable "region" {}
variable customer_label{
    default = ""
}
variable "compartment_ocid" {
  
}
variable "subnet_compartment" {} 

#########################################################################

### Compute Specific

variable "subnet_ocid1" {}

variable "availablity_domain_name" {
  default = "3"
}
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
variable instance_shape {
    default = "VM.Standard.E2.1"
}
variable "computeip" {}
variable "ssh_key_nonprod" {}
variable "instance_os" {}
variable "linux_os_version" {}

variable "nsg1" {
default = []
}
variable "nsg2" {
default = []
}
variable "nsg3" {
default = []
}
locals {

nsg = flatten( [ var.nsg1,var.nsg2, var.nsg3] )

}
############################################################################

### DB Specific 
variable "subnet_ocid2" {}
variable "availablity_domain_name2" {
  default = "2"
}
variable "character_set" {
  default = "WE8MSWIN1252"
}
variable "db_ncharacter_set" {
  default = "AL16UTF16"
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
variable "db_shape" {
  default = "VM.Standard2.2"
}

variable "ssh_key_db" {}


#####################################################################################################

##############Tagging##############
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

