#!/bin/sh

docker-compose config |\
  yq -crM '.services | with_entries(select(.value | has("build"))) | to_entries | map(. | {service: .key, image: .value.image, dockerfile: .value.build.dockerfile})'