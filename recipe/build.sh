#!/bin/bash

set -ex

mkdir build
cd build

export TEST=ON

export CXXFLAGS="${CXXFLAGS} -std=c++11 -ldl"

if [ "$(uname)" == "Linux" ]; then
   export LDFLAGS="${LDFLAGS} -Wl,-rpath-link,${PREFIX}/lib"
fi

cmake -G "Unix Makefiles" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_LIBRARY_PATH=$PREFIX/lib \
  -DCMAKE_INCLUDE_PATH=$PREFIX/include \
  -DENABLE_TESTS=$TEST \
  -DCMAKE_CXX_FLAGS=-Wno-unused-command-line-argument \
  ..

make -j $CPU_COUNT
make install
export PATH=$PATH:$PREFIX/lib

export GRIB_ADJUST_LONGITUDE_RANGE=NO
ctest -VV --exclude-regex "mdal_gdal_netcdf*"
