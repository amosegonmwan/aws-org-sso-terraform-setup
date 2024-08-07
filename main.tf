# Org creation
resource "aws_organizations_organizational_unit" "workloads" {
  for_each = toset(local.workload_ous)

  name      = each.value
  parent_id = local.root_ou
}

# Create accounts
resource "aws_organizations_account" "dev" {
  for_each = local.ou

  name  = each.value.name
  email = each.value.email

  parent_id = local.target_id
}

