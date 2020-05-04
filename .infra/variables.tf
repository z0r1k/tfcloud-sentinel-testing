variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "tag_user_name" {
  type = string
}

variable "tag_department" {
  type    = string
  default = "Teletubbies"
}

variable "tag_billable" {
  type    = bool
  default = true
}
