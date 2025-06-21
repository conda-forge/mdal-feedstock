#!/bin/bash

set -ex

mkdir build
cd build

export TEST=ON

if [ "$(uname)" == "Linux" ]; then
   export CXXFLAGS="${CXXFLAGS} -ldl"
fi

cmake -G "Unix Makefiles" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_LIBRARY_PATH=$PREFIX/lib \
  -DCMAKE_INCLUDE_PATH=$PREFIX/include \
  -DENABLE_TESTS=$TEST \
  -DCMAKE_POLICY_VERSION_MINIMUM=3.9 \
  ..

make -j $CPU_COUNT
make install
export PATH=$PATH:$PREFIX/lib

export GRIB_ADJUST_LONGITUDE_RANGE=NO
ctest -VV --exclude-regex "mdal_gdal_grib"
