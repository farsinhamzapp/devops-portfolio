variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "kube_context" {
  description = "Kubeconfig context to use"
  type        = string
  default     = "kind-devops-portfolio"
}

variable "app_image" {
  description = "Full image reference to deploy (e.g. ghcr.io/user/devops-portfolio:tag)"
  type        = string
  default     = "devops-demo-api:local"
}

variable "replica_count" {
  description = "Number of pod replicas"
  type        = number
  default     = 2
}

variable "namespace" {
  description = "Kubernetes namespace for the app"
  type        = string
  default     = "devops-demo"
}
