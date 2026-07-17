terraform {
  required_version = ">= 1.5.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.31"
    }
  }
}

# Points Terraform at whatever kubeconfig context is currently active.
# Locally that's "kind-devops-portfolio". In CI, the workflow creates
# a fresh kind cluster and its context is used automatically.
provider "kubernetes" {
  config_path    = var.kubeconfig_path
  config_context = var.kube_context
}
