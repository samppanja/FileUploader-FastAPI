# syntax=docker/dockerfile:1
FROM ubuntu:24.04

WORKDIR /app

ENV PATH="/root/.local/bin/:$PATH"

RUN apt-get update && apt-get install -y pipx ca-certificates libmagic1 \
    && pipx install "uv==0.6.3" \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY pyproject.toml uv.lock ./
RUN uv sync --no-dev --frozen

COPY . /app

CMD [ "uv", "run", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"] 