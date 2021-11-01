FROM python:3.10.0 as python-base

ENV \
    # python
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONFAULTHANDLER=1 \
    # pip
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    # poetry
    POETRY_VERSION=1.1.11 \
    POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    POETRY_NO_INTERACTION=1 \
    # multi-stages
    STAGING_PATH="/opt/staging" 

ENV VENV_PATH="$STAGING_PATH/.venv" 
ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"

# Install Poetry - respects $POETRY_VERSION & $POETRY_HOME
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python

# We copy our Python requirements here to cache them
# and install only runtime deps using poetry
WORKDIR $STAGING_PATH
COPY ./poetry.lock ./pyproject.toml ./
RUN poetry install --no-dev

# Production image
FROM python-base as production

# Get installed dependencies
COPY --from=python-base $VENV_PATH $VENV_PATH

# Entrypoint script
COPY ./docker/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Source code
COPY ./coach-planner $STAGING_PATH

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["gunicorn", "--bind", ":$PORT", "--workers", "1", "--threads", "1", "--timeout", "0", "app:app"]