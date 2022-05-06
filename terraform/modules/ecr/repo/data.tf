data "aws_iam_policy_document" "policy" {
  statement {
    sid    = "AllowPull"
    effect = "Allow"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
    ]

    principals {
      type        = "AWS"
      identifiers = [for account_id in var.allowed_aws_account_ids : "arn:aws:iam::${account_id}:root"]
    }
  }

  statement {
    sid    = "AllowPush"
    effect = "Allow"
    actions = [
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload"
    ]

    principals {
      type        = "AWS"
      identifiers = [for account_id in var.allowed_aws_account_ids : "arn:aws:iam::${account_id}:root"]
    }
  }
}
