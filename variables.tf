variable "region" {
  default = "eu-west-2"
}

variable "azs" {
  default = ["eu-west-2a", "eu-west-2b"]
}

variable "keyname" {
  default = "poc-docker-ee"
}

variable "docker_ee_subscription_id" {}
variable "docker_ee_channel" {}