# syntax=docker/dockerfile:1
FROM ubuntu:24.04

WORKDIR /app

ENV PATH="/root/.local/bin/:$PATH"
COPY . /app

RUN apt-get update && apt-get install -y curl ca-certificates libmagic1 && curl -LsSf https://astral.sh/uv/install.sh | sh \
&& apt-get clean && rm -rf /var/lib/apt/lists/* \
&& uv sync --no-dev



CMD [ "uv", "run", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"] 