output "id" {
  description = <<EOF
  "

  "
  EOF
  value       = aws_key_pair.this.id
}

output "arn" {
  description = <<EOF
  "

  "
  EOF
  value       = aws_key_pair.this.arn
}

output "key_name" {
  description = <<EOF
  "

  "
  EOF
  value       = aws_key_pair.this.key_name
}

output "key_pair_id" {
  description = <<EOF
  "

  "
  EOF
  value       = aws_key_pair.this.key_pair_id
}

output "fingerprint" {
  description = <<EOF
  "

  "
  EOF
  value       = aws_key_pair.this.fingerprint
}

output "tags_all" {
  description = <<EOF
  "

  "
  EOF
  value       = aws_key_pair.this.tags_all
}
