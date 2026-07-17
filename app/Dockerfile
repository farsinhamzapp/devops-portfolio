# --- Build/runtime image ---
FROM python:3.12-slim

WORKDIR /app

# Install deps first so Docker can cache this layer when only
# app code changes (faster rebuilds).
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY main.py .

# Run as a non-root user (basic container security hygiene —
# worth mentioning if asked about it in an interview).
RUN useradd --create-home appuser
USER appuser

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=3s \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')" || exit 1

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "main:app"]
