# Configure the AWS Provider
provider "aws" {
  version = "= 2.22.0"
  region  = var.default_region
}

provider "kubernetes" {
  version                = "1.7"
  host                   = local.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(local.eks_cluster_certificate_authority_data)
  token                  = local.eks_cluster_authentication_token
  load_config_file       = false
}


