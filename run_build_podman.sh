#!/bin/sh

set -e
podman pull debian:bookworm
podman build debian-builder -t neovim-debian-builder
mkdir -p output
podman run -i --rm \
  -v "`pwd`/output:/output" \
  neovim-debian-builder /bin/sh < build_nvim.sh
