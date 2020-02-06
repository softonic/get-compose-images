#!/bin/sh

docker-compose config |\
  yq -crM '.services | with_entries(select(.value | has("build"))) | to_entries | map(. | {service: .key, image: .value.image, dockerfile: .value.build.dockerfile}) | map( select(.image != null) | with_entries( select( .value != 0 )) ) | .[].dockerfile //= "Dockerfile"'