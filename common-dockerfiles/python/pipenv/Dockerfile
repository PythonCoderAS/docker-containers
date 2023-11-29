# Assumptions:
# Pipfile and Pipefile.lock are in /app

ARG PYTHON_VERSION

FROM python:${PYTHON_VERSION} as generate-requirements

# Path: /app
WORKDIR /app

RUN ["pip", "install", "pipenv"]
RUN ["sh", "-c", "pipenv requirements --dev > requirements.txt"]

FROM python:3.12 as build

# Path: /app
WORKDIR /app

COPY --from=generate-requirements /app/requirements.txt ./

RUN ["python3", "-m", "venv", "/venv"]
ENV PATH="/venv/bin:$PATH"
RUN ["python3", "-m", "pip", "install", "-r", "requirements.txt"]