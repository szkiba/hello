#!/usr/bin/env bats

function setup() {
    ARCH=$(dpkg --print-architecture)
    PROJECT=$(yq -r '.project_name' .goreleaser.y*ml)
    EXE="$(ls dist/${PROJECT}_linux_${ARCH}_v*/${PROJECT})"

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
