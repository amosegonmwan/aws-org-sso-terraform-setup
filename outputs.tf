output "my_org" {
  value = data.aws_organizations_organization.current.roots[*].id
}

output "my_accounts" {
  value = data.aws_organizations_organization.current.accounts[*].id
}

output "ou" {
  value = data.aws_organizations_organizational_units.ou.children
}