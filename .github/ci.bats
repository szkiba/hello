#!/usr/bin/env bats

function setup() {
    PROJECT=$(yq -r '.project_name' .goreleaser.yaml)
    EXE="dist/${PROJECT}_linux_amd64_v1/${PROJECT}"

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
