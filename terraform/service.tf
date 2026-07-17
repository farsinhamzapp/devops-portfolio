resource "kubernetes_service" "app" {
  metadata {
    name      = "devops-demo-api"
    namespace = kubernetes_namespace.app.metadata[0].name
  }

  spec {
    selector = {
      app = "devops-demo-api"
    }

    port {
      port        = 80
      target_port = 5000
    }

    type = "NodePort"
  }
}
