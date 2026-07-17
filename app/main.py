from flask import Flask, jsonify
import os
import datetime

app = Flask(__name__)

APP_VERSION = os.environ.get("APP_VERSION", "1.0.0")


@app.route("/")
def index():
    return jsonify({
        "message": "Hello from the DevOps demo API",
        "version": APP_VERSION,
        "timestamp": datetime.datetime.utcnow().isoformat()
    })


@app.route("/health")
def health():
    # Used by the CI/CD pipeline's smoke test and by Kubernetes
    # liveness/readiness probes.
    return jsonify({"status": "healthy"}), 200


@app.route("/api/tasks", methods=["GET"])
def list_tasks():
    # Fake in-memory data so the API has more than one endpoint
    # to demonstrate. Swap for a real DB later if you want to
    # extend this project.
    tasks = [
        {"id": 1, "title": "Set up CI/CD pipeline", "done": True},
        {"id": 2, "title": "Deploy to Kubernetes", "done": True},
        {"id": 3, "title": "Add monitoring", "done": False},
    ]
    return jsonify(tasks)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
