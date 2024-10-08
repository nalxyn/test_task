FROM python:3.11-slim

RUN apt-get update \
    && apt-get install -y postgresql-client libpq-dev gcc \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY pyproject.toml .
COPY poetry.lock .

RUN pip install --no-cache-dir poetry \
    && poetry config virtualenvs.create false \
    && poetry install --only main --no-interaction --no-ansi

COPY . .
COPY prestart.sh .
RUN ls -la

RUN chmod +x prestart.sh
RUN ls -la
ENTRYPOINT  ["bash", "./start.sh"]

CMD ["python", "main.py"]
