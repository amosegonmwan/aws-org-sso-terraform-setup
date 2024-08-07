# EKS readOnly permission sets
resource "aws_ssoadmin_permission_set" "eks_readOnly" {
  name             = "EKSReadOnly"
  description      = "AWS Admin access in all accounts"
  instance_arn     = local.sso_instance_id
  session_duration = "PT4H"
}

resource "aws_ssoadmin_permission_set_inline_policy" "eks_readOnly" {
  instance_arn       = local.sso_instance_id
  permission_set_arn = aws_ssoadmin_permission_set.eks_readOnly.arn
  inline_policy      = local.eks_permission_policy_statement
}

resource "aws_ssoadmin_account_assignment" "all_accounts_assignment" {
  for_each = toset(local.target_accounts)

  instance_arn       = local.sso_instance_id
  permission_set_arn = aws_ssoadmin_permission_set.eks_readOnly.arn

  principal_id   = aws_identitystore_group.admin.group_id
  principal_type = "GROUP"

  target_id   = each.value
  target_type = "AWS_ACCOUNT"

  depends_on = [aws_organizations_account.dev]
}

resource "aws_ssoadmin_permission_set" "readOnly" {
  name             = "ReadOnly"
  instance_arn     = local.sso_instance_id
  session_duration = "PT4H"
}

resource "aws_ssoadmin_managed_policy_attachment" "readOnly" {
  instance_arn       = local.sso_instance_id
  managed_policy_arn = "arn:aws:iam::aws:policy/readOnlyAccess"
  permission_set_arn = aws_ssoadmin_permission_set.readOnly.arn
}

resource "aws_ssoadmin_account_assignment" "readOnly" {
  for_each = toset(local.target_accounts)

  instance_arn       = local.sso_instance_id
  permission_set_arn = aws_ssoadmin_permission_set.readOnly.arn

  principal_id   = aws_identitystore_group.readOnly.group_id
  principal_type = "GROUP"

  target_id   = each.value
  target_type = "AWS_ACCOUNT"

  depends_on = [aws_organizations_account.dev]
}

resource "aws_ssoadmin_permission_set" "adminAccess" {
  name         = "AdminCreds"
  instance_arn = local.sso_instance_id
}

resource "aws_ssoadmin_managed_policy_attachment" "admin" {
  instance_arn       = local.sso_instance_id
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  permission_set_arn = aws_ssoadmin_permission_set.adminAccess.arn
}

resource "aws_ssoadmin_account_assignment" "admin" {
  for_each = toset(local.target_accounts)

  instance_arn       = local.sso_instance_id
  permission_set_arn = aws_ssoadmin_permission_set.adminAccess.arn

  principal_id   = aws_identitystore_group.admin.group_id
  principal_type = "GROUP"

  target_id   = each.value
  target_type = "AWS_ACCOUNT"

  depends_on = [aws_organizations_account.dev]
}

resource "aws_identitystore_group" "readOnly" {
  display_name      = "readOnly"
  description       = "Read only group"
  identity_store_id = tolist(data.aws_ssoadmin_instances.instance.identity_store_ids)[0]
}

resource "aws_identitystore_group" "admin" {
  display_name      = "admin"
  description       = "Admin group"
  identity_store_id = tolist(data.aws_ssoadmin_instances.instance.identity_store_ids)[0]
}