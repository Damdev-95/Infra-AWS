variable "aws_region" {
  type = string
  description = "The AWS region to create things in."
}

variable "project" {
  description = "Project tag."
}

variable "vpc_cidr" {
  type        = string
  description = "The VPC cidr block"
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in."
}

variable "allowed_hosts" {
  description = "CIDR blocks of trusted networks"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}


variable "internal_networks" {
  type        = list(string)
  description = "Internal network CIDR blocks."
}


variable "availability_zones" {
  default     = "us-east-1b,us-east-1c,us-east-1d,us-east-1e"
  description = "List of availability zones"
}

variable "ami" {
  type        = string
  description = "AMI id for the launch template"

}


variable "instance_type" {
  type = string
  description = "AWS instance type"
}

variable "asg_min" {
  description = "Min numbers of servers in ASG"
  default     = "2"
}

variable "asg_max" {
  description = "Max numbers of servers in ASG"
  default     = "3"
}

variable "asg_desired" {
  description = "Desired numbers of servers in ASG"
  default     = "2"
}

variable "enable_dns_support" {
  type = bool
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "name" {
  type    = string
  default = "Python_APP"

}

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}


variable "keypair" {
  type        = string
  description = "keypair for the ec2 instances"

}

variable "disk_size" {
  type = string
  description = "Size of the block storage"
}