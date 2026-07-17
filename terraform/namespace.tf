resource "kubernetes_namespace" "app" {
  metadata {
    name = var.namespace

    labels = {
      environment = "demo"
      managed-by  = "terraform"
    }
  }
}
