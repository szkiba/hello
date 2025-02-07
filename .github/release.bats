#!/usr/bin/env bats

function arch() {
    if [ "$RUNNER_ARCH" = "ARM64" ]; then
      echo -n "arm64"
    fi

    echo -n "amd64"
}

function setup() {
    ARCH=$(arch)
    REPO=${GITHUB_REPOSITORY:-szkiba/hello}
    IMAGE=${REPO}:latest-$ARCH

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
