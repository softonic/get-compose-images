# get-compose-images

It returns a JSON structure with the images to build in the equivalent `docker-compose xxxx build` command.

This is useful to detect what are the images to build and use this info anywhere, for example for asynchronous
image scan.

## Usage

You need to execute the image mounting the desired file or directory that contains the docker compose data and the
environment parameters you need for the expected compose output.

For example:

```bash
docker run --rm \
  -v ${PWD}:/code:ro -it \
  -e COMPOSE_FILE=docker-compose.sample.yml \
  -e VERSION=1.0.0-test \
  -e NGINX_VERSION=3.4.5
  softonic/get-compose-images:latest
```

```json
[
  {
    "service": "docs",
    "image": "my.registry.io/magic-api/docs:1.0.0-test",
    "dockerfile": "docker/docs/Dockerfile"
  },
  {
    "service": "nginx",
    "image": "my.registry.io/magic-api/nginx:3.4.5",
    "dockerfile": "docker/nginx/Dockerfile"
  },
  {
    "service": "php-fpm",
    "image": "my.registry.io/magic-api/php-fpm:1.0.0-test",
    "dockerfile": "docker/php-fpm/Dockerfile"
  }
]
```