# syntax=docker/dockerfile:1
FROM ubuntu:24.04

WORKDIR /app

ENV PATH="/root/.local/bin/:$PATH"
COPY . /app

RUN apt-get update && apt-get install -y python3-pip ca-certificates libmagic1 \
    && pip3 install --no-cache-dir --break-system-packages "uv==0.6.3" \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && uv sync --no-dev --frozen



CMD [ "uv", "run", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"] 