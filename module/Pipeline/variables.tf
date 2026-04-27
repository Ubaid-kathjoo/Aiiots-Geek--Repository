variable "project_name" {}
variable "artifact_bucket_name" {}
variable "deploy_bucket_name" {}

variable "github_owner" {}
variable "github_repo" {}
variable "github_branch" {
  default = "main"
}
variable "github_token" {}