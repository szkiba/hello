#!/usr/bin/env bats

setup() {
  cd $BATS_TEST_DIRNAME

  IMAGE=szkiba/hello:latest-$(dpkg --print-architecture)

  if [ -z "$(docker images $IMAGE --format json)" ]; then
    echo "    - building release" >&3
    goreleaser release --clean --snapshot
  fi
}

@test 'docker run' {
  echo "    - dumb" >&3
  echo "    - dumber" >&3
  run docker run --rm $IMAGE

  [ $status -eq 0 ]
  [ "$output" = "Hello, World!" ]
}
