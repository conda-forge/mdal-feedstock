#!/bin/bash

set -ex

mkdir build
cd build

export TEST=ON

if [ "$(uname)" == "Linux" ]; then
   export LDFLAGS="${LDFLAGS} -Wl,-rpath-link,${PREFIX}/lib"
   export TEST=OFF
fi

cmake -G "Unix Makefiles" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_LIBRARY_PATH=$PREFIX/lib \
  -DCMAKE_INCLUDE_PATH=$PREFIX/include \
  -DENABLE_TESTS=$TEST \
  ..

make -j $CPU_COUNT
make install
export PATH=$PATH:$PREFIX/lib
if ["$TEST" == "ON"]; then
  ctest -VV
fi
