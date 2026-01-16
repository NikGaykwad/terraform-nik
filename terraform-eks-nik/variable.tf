variable "aws_region" {
  default = "ap-south-1"
  description = "aws region"
}

variable "vpc_name" {
  default = "eks-clsuter-nik-vpc"
  description = "this is VPC name"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "nik-demo-eks-clsuter"
}

variable "kubernetes_version" {
  default     = 1.27
  description = "kubernetes version"
}
