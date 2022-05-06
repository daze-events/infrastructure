resource "aws_ecr_repository" "this" {
  name = var.name

  encryption_configuration {
    encryption_type = var.encryption_configuration_type
    kms_key         = var.encryption_configuration_kms_key_arn
  }

  image_scanning_configuration {
    scan_on_push = var.image_scanning_scan_on_push
  }

  image_tag_mutability = var.image_tag_mutability
  tags                 = var.tags
}

resource "aws_ecr_repository_policy" "policy" {
  repository = aws_ecr_repository.this.name
  policy     = data.aws_iam_policy_document.policy.json
}
