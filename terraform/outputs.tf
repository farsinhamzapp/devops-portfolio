output "namespace" {
  value = kubernetes_namespace.app.metadata[0].name
}

output "service_name" {
  value = kubernetes_service.app.metadata[0].name
}

output "node_port" {
  description = "NodePort the service is exposed on. Use with 'kubectl port-forward' or the node IP to reach the app."
  value       = kubernetes_service.app.spec[0].port[0].node_port
}
