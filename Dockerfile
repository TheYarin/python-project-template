# For more information, please refer to https://aka.ms/vscode-docker-python
# FROM python:3.11-slim-buster as base
# Using microsoft's image because it addresses a few CVEs on top of python's official image
FROM mcr.microsoft.com/devcontainers/python:0-3.11 as base

RUN pip install pipenv
# >> Insert dependencies shared between dev and prod here <<

FROM base as prod

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE 1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED 1

WORKDIR /app

# Switching to a non-root user, please refer to https://aka.ms/vscode-docker-python-user-rights
RUN mkdir /home/appuser
# Specific uid (user id) and gid (group id) are used because the docker host will need to allow those to access the logs folder later on using `setfacl -m u:555:rwx <path-to-logs-folder>`
RUN groupadd -g 556 appuser && \
    useradd -r -u 555 -g appuser appuser && chown -R appuser /app /home/appuser
USER appuser
ENV PATH=${PATH}:/home/appuser/.local/bin

# Install python dependencies
COPY --chown=appuser Pipfile* /app/
RUN pipenv install --deploy --ignore-pipfile

COPY --chown=appuser /src /app

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
CMD ["pipenv", "run", "python", "./main.py"]
