resource "kubernetes_deployment" "app" {
  metadata {
    name      = "devops-demo-api"
    namespace = kubernetes_namespace.app.metadata[0].name

    labels = {
      app = "devops-demo-api"
    }
  }

  spec {
    replicas = var.replica_count

    selector {
      match_labels = {
        app = "devops-demo-api"
      }
    }

    template {
      metadata {
        labels = {
          app = "devops-demo-api"
        }
      }

      spec {
        container {
          name  = "devops-demo-api"
          image = var.app_image

          port {
            container_port = 5000
          }

          resources {
            requests = {
              cpu    = "50m"
              memory = "64Mi"
            }
            limits = {
              cpu    = "200m"
              memory = "128Mi"
            }
          }

          # Kubernetes hits this to decide whether the pod should
          # keep receiving traffic. Backed by the /health route
          # we built into the Flask app on Day 1.
          readiness_probe {
            http_get {
              path = "/health"
              port = 5000
            }
            initial_delay_seconds = 3
            period_seconds        = 5
          }

          # If this fails repeatedly, Kubernetes restarts the pod.
          liveness_probe {
            http_get {
              path = "/health"
              port = 5000
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }
        }
      }
    }
  }
}
