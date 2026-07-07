# --- Stage 1: Build & Dependency Gathering ---
FROM python:3.9-slim AS builder

WORKDIR /app

# Install system dependencies needed to compile certain Python wheels
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

# Build wheels in a localized directory to isolate build dependencies
RUN pip install --no-cache-dir --user -r requirements.txt


# --- Stage 2: Final Slim Runtime Image ---
FROM python:3.9-slim AS runner

WORKDIR /app

# Install runtime database binaries (libpq is needed for psycopg2)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq5 \
    && rm -rf /var/lib/apt/lists/*

# Copy installed dependencies from the builder stage
COPY --from=builder /root/.local /root/.local
COPY . .

# Ensure the local pip binaries are accessible on the system environment path
ENV PATH=/root/.local/bin:$PATH
ENV FLASK_APP=service:app
ENV PORT=8080

# Expose the production container port
EXPOSE 8080

# Switch to a non-root service user for enhanced container security compliance
USER 1001

# Launch the microservice app layer using Gunicorn production server
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "--log-level", "info", "service:app"]
