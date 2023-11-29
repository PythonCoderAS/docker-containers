FROM alpine/git as clone
ARG GIT_REPO=pokestarbot-v1
ARG GIT_OWNER=PythonCoderAS
ARG GIT_CLONE_URL="https://github.com/${GIT_OWNER}/${GIT_REPO}.git"
ARG GIT_BRANCH=master

RUN git clone --depth 1 --branch ${GIT_BRANCH} ${GIT_CLONE_URL} /app
RUN rm -rf /app/.git

FROM python:3.8 as generate-requirements

# Path: /app
COPY --from=clone /app /app
WORKDIR /app

RUN ["pip", "install", "pipenv"]
RUN ["sh", "-c", "pipenv requirements --dev > requirements.txt"]
RUN ["rm", "Pipfile", "Pipfile.lock"]

FROM python:3.8 as build

# Path: /app
WORKDIR /app

COPY --from=generate-requirements /app/requirements.txt ./

RUN ["python3", "-m", "venv", "/venv"]
ENV PATH="/venv/bin:$PATH"
RUN ["python3", "-m", "pip", "install", "-r", "requirements.txt"]

FROM python:3.8-slim as final
COPY --from=build /venv /venv
COPY --from=clone /app /app
WORKDIR /app
ENV PATH="/venv/bin:$PATH"
ENTRYPOINT [ "python3", "/app/bot.py" ]