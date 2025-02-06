#!/bin/sh
set -e

eval "$(fixids -q hello hello)"

exec hello "$@"
