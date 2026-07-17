from main import app


def get_client():
    app.testing = True
    return app.test_client()


def test_health_endpoint():
    client = get_client()
    response = client.get("/health")
    assert response.status_code == 200
    assert response.get_json()["status"] == "healthy"


def test_index_endpoint():
    client = get_client()
    response = client.get("/")
    assert response.status_code == 200
    body = response.get_json()
    assert "message" in body
    assert "version" in body


def test_tasks_endpoint():
    client = get_client()
    response = client.get("/api/tasks")
    assert response.status_code == 200
    tasks = response.get_json()
    assert isinstance(tasks, list)
    assert len(tasks) == 3
