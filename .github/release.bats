#!/usr/bin/env bats

function setup() {
    REPO=${GITHUB_REPOSITORY:-szkiba/hello}
    IMAGE=${REPO}:latest-amd64

    if [ -z "$(docker images $IMAGE --format json)" ] ; then
      echo "    - building release" >&3
      goreleaser release --clean --snapshot
    fi
}

@test 'docker run' {
    run docker run --rm ${REPO}:latest-amd64

    [ $status -eq 0 ]
    [ "$output" = "Hello, World!" ]
}
