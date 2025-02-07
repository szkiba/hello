#!/usr/bin/env bats

function arch() {
    if [ "$RUNNER_ARCH" = "ARM64" ]; then
      echo -n "arm64"
    fi

    echo -n "amd64"
}

function setup() {
    ARCH=$(arch)
    PROJECT=$(yq -r '.project_name' .goreleaser.yaml)
    EXE="dist/${PROJECT}_linux_${ARCH}_v1/${PROJECT}"

    if [ ! -x "$EXE" ] ; then
      echo "    - building snapshot" >&3
      goreleaser build --clean --snapshot --single-target
    fi
}

@test 'execute' {
    run $EXE

    [ $status -eq 0 ]
    [ "$output" = "Hello, World!" ]
}
