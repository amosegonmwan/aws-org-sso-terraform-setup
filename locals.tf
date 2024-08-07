locals {
  sso_instance_id       = tolist(data.aws_ssoadmin_instances.instance.arns)[0]
  sso_identity_store_id = tolist(data.aws_ssoadmin_instances.instance.identity_store_ids)[0]
  aws_org_id            = data.aws_organizations_organization.current.id
  root_ou               = "r-rl20"
  target_id             = data.aws_organizations_organization.current.roots[0].id

  target_accounts = [
    aws_organizations_account.dev["sandbox"].id,
    aws_organizations_account.dev["staging"].id,
    aws_organizations_account.dev["dev"].id,
    aws_organizations_account.dev["prod"].id
  ]

  ou = {
    sandbox = {
      name  = "amos-sandbox"
      email = "amos.egonmwan+1@gmail.com"
    }

    staging = {
      name  = "amos-staging"
      email = "amos.egonmwan+2@gmail.com"
    }

    dev = {
      name  = "amos-dev"
      email = "amos.egonmwan+3@gmail.com"
    }

    prod = {
      name  = "amos-prod"
      email = "amos.egonmwan+4@gmail.com"
    }
  }


  workload_ous = [
    "sandbox",
    "staging",
    "dev",
    "prod"
  ]

  eks_permission_policy_statement = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "eks:List*",
          "eks:Describe*",
          "eks:Get*"
        ]
        Resource = "*"
      }
    ]
  })
}
