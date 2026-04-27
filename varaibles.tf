variable "Name" {
  default = "LinuxServer"
}

variable "env" {

}


variable "my_project" {
  default = "demo-terraform"
}
variable "github_token" {
  description = "GitHub personal access token"
  type        = string
}