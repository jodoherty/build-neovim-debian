#!/bin/sh

set -e

git clone -b stable --single-branch --depth 1 https://github.com/neovim/neovim
cd neovim
(mkdir .deps && cd .deps && \
  cmake -G Ninja ../cmake.deps/ \
    -DCMAKE_BUILD_TYPE=Release \
    -DUSE_BUNDLED=OFF -DUSE_BUNDLED_LIBUV=ON -DUSE_BUNDLED_LUV=ON \
    -DUSE_BUNDLED_LIBVTERM=ON -DUSE_BUNDLED_TS=ON \
    && \
  ninja)
(mkdir build && cd build && \
  cmake -G Ninja .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCPACK_DEBIAN_PACKAGE_NAME=nvim-opt \
    && \
  ninja && \
  ninja package)
cp build/nvim-linux64.deb "/output/nvim-linux64-`uname -m`.deb"
