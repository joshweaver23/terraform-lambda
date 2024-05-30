module "lambda_example" {
  source = "./modules/lambda"

  ns          = local.ns
  name        = "example"
  description = "Example Lambda Function"
  role_arn    = module.role.role.arn
  memory      = 1024

  tags = local.tags

  vpc = {
    subnet_ids = [for s in data.aws_subnet.private : s.id]
    security_group_ids = [
      data.aws_security_group.managed.id,
    ]
  }
}

module "role" {
  source = "../lambda/role"

  ns   = var.ns
  name = var.name
  tags = var.tags

  policy_documents = [data.aws_iam_policy_document.permissions.json]
}
