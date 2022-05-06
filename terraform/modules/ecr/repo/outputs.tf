output "arn" {
  description = <<EOF
  "
  Full ARN of the repository.
  "
  EOF
  value       = aws_ecr_repository.this.arn
}

output "name" {
  description = <<EOF
  "
  Name of the repository.
  "
  EOF
  value       = aws_ecr_repository.this.name
}

output "registry_id" {
  description = <<EOF
  "
  The registry ID where the repository was created.
  "
  EOF
  value       = aws_ecr_repository.this.registry_id
}

output "repository_url" {
  description = <<EOF
  "
  The URL of the repository (in the form aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName).
  "
  EOF
  value       = aws_ecr_repository.this.repository_url
}

output "tags_all" {
  description = <<EOF
  "
  A map of tags assigned to the resource, including those inherited from the provider `default_tags` configuration block.
  "
  EOF
  value       = aws_ecr_repository.this.tags_all
}
