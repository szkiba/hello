#!/usr/bin/env bats

setup() {
  cd $BATS_TEST_DIRNAME

  echo "k6 versions: $K6_VERSIONS" >&3

  EXE="$(ls $(git rev-parse --show-toplevel)/dist/hello.exe)"

  if [ ! -x "$EXE" ]; then
    echo "    - building snapshot" >&3
    goreleaser build --clean --snapshot --single-target --id hello -o dist/hello.exe
  fi
}

@test 'execute' {
  run $EXE

  [ $status -eq 0 ]
  [ "$output" = "Hello, World!" ]
}
