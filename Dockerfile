FROM python:3.9-alpine3.13
LABEL maintainer="Insaf Ahammed"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt tmp/requirements.txt
COPY ./requirements-dev.txt tmp/requirements-dev.txt
COPY ./app /app
# default workdir run command in this directory
WORKDIR /app
# expose port 8000
EXPOSE 8000

ARG DEV=false
# with minimal layers
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ true = "true" ]; then \
        /py/bin/pip install -r /tmp/requirements-dev.txt; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user




