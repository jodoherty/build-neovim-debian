#!/bin/sh

set -e

for release in bullseye bookworm
do
  podman pull debian:$release
  podman build debian-$release-builder -t neovim-debian-$release-builder
  mkdir -p output-$release
  podman run -i --rm \
    -v "`pwd`/output-$release:/output" \
    neovim-debian-$release-builder /bin/sh < build_nvim.sh
done
