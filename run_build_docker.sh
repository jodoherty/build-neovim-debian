#!/bin/sh

set -e

for release in bullseye bookworm
do
  docker pull debian:$release
  docker build debian-$release-builder -f debian-$release-builder/Containerfile -t neovim-debian-$release-builder
  mkdir -p output-$release
  docker run -i --rm \
    -v "`pwd`/output-$release:/output" \
    neovim-debian-$release-builder /bin/sh < build_nvim.sh
done
