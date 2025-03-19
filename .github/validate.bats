#!/usr/bin/env bats

setup() {
  cd $BATS_TEST_DIRNAME

  echo "k6 versions: $K6_VERSIONS" >&3

  EXE="$(ls $(git rev-parse --show-toplevel)/dist/hello_linux_$(dpkg --print-architecture)_v*/hello)"

  if [ ! -x "$EXE" ]; then
    echo "    - building snapshot" >&3
    goreleaser build --clean --snapshot --single-target
  fi
}

@test 'execute' {
  echo "    - dumb" >&3
  echo "    - dumber" >&3

  run $EXE

  [ $status -eq 0 ]
  [ "$output" = "Hello, World!" ]
}
