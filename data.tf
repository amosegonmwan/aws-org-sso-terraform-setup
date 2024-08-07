data "aws_organizations_organization" "current" {}

data "aws_ssoadmin_instances" "instance" {}

data "aws_organizations_organizational_units" "ou" {
  parent_id = local.target_id
}

