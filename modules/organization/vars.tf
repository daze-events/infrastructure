variable "aws_service_access_principals" {
  description = <<EOF
  List of AWS service principal names for which you want to enable integration with your organization.
  This is typically in the form of a URL, such as service-abbreviation.amazonaws.com.
  Organization must have feature_set set to ALL."
  EOF
  type        = list(string)
  default     = []
}

variable "feature_set" {
  description = <<EOF
  Specify "ALL" or "CONSOLIDATED_BILLING".
  EOF
  type        = string
  default     = "ALL"
}

variable "enabled_policy_types" {
  description = <<EOF
  List of Organizations policy types to enable in the Organization Root.
  Organization must have feature_set set to ALL. For additional information about valid policy types
  (e.g., AISERVICES_OPT_OUT_POLICY, BACKUP_POLICY, SERVICE_CONTROL_POLICY, and TAG_POLICY), see the AWS Organizations API Reference
  https://docs.aws.amazon.com/organizations/latest/APIReference/API_EnablePolicyType.html.
  EOF
  type        = list(string)
  default = [
    "AISERVICES_OPT_OUT_POLICY",
    "BACKUP_POLICY",
    "SERVICE_CONTROL_POLICY",
    "TAG_POLICY"
  ]
}
