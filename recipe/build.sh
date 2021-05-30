#!/bin/bash

set -ex

mkdir build
cd build

cmake -G "Unix Makefiles" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_LIBRARY_PATH=$PREFIX/lib \
  -DCMAKE_INCLUDE_PATH=$PREFIX/include \
  -DENABLE_TESTS=ON \
  ..

make -j $CPU_COUNT
make install
export PATH=$PATH:$PREFIX/lib
ctest -VV
