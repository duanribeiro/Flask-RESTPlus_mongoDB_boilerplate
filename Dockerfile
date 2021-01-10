## develop image
FROM python:3.8-slim AS develop

## install dependencies
RUN apt-get update

## set working directory
WORKDIR /usr/src/app

## add and install requirements
ADD . .
RUN pip3 install --upgrade pip; pip3 install pip-tools
RUN pip3 install -r requirements.txt

## add user
RUN addgroup --system user; adduser --system --no-create-home --group user
RUN chown -R user:user .; chmod -R 775 .

## add entrypoint.sh
RUN chmod +x ./entrypoint.sh

## switch to non-root user
USER user

## set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PATH="/opt/venv/bin:$PATH"

## run entrypoint.sh
CMD ./entrypoint.sh