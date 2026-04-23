terraform {
  backend "s3" {
    bucket = "avinash-bucket-097"
    key    = "secops-dev.tfstae"
    region = "ap-south-1"
  }
}
terraform {
  required_version = ">= 0.15.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.29.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 4.0.0"
    }
    template = {
      source  = "hashicorp/template"
      version = ">= 4.0.0"
    }
  }
}
provider "aws" {
  region              = var.region
  allowed_account_ids = [342831714463]

  default_tags {
    tags = local.default_tags
  }
}
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.eks.token

}
provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}
