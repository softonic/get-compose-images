FROM alpine:3.11.3

ARG version="0.1.0-dev"
ARG build_date="unknown"
ARG commit_hash="unknown"
ARG vcs_url="unknown"
ARG vcs_branch="unknown"

ENV YQ_VERSION=2.10.0\
    DOCKER_COMPOSE_VERSION=1.25.3

LABEL org.label-schema.vendor="softonic" \
    org.label-schema.name="get-compose-images" \
    org.label-schema.description="Obtains the built images and their tags in JSON format" \
    org.label-schema.usage="/src/README.md" \
    org.label-schema.url="https://github.com/softonic/get-compose-images/blob/master/README.md" \
    org.label-schema.vcs-url=$vcs_url \
    org.label-schema.vcs-branch=$vcs_branch \
    org.label-schema.vcs-ref=$commit_hash \
    org.label-schema.version=$version \
    org.label-schema.schema-version="1.0" \
    org.label-schema.build-date=$build_date \
    org.label-schema.docker.cmd="docker run --rm \
        -v ${PWD}:/code:ro \
        -e COMPOSE_FILE=docker-compose.yml \
        -e VERSION=1.0.0-test \
        softonic/get-compose-images:latest" \
    org.label-schema.docker.params="COMPOSE_FILE=Compose file to use \
        VERSION=Version parameter to use in the compose file, just an example"

RUN apk add --update --no-cache python-dev py-pip jq build-base libffi-dev openssl-dev libgcc &&\
    pip install --no-cache-dir "yq==${YQ_VERSION}" "docker-compose==${DOCKER_COMPOSE_VERSION}"
COPY ./get-compose-images.sh /get-compose-images.sh

WORKDIR /code

CMD ["/get-compose-images.sh"]
