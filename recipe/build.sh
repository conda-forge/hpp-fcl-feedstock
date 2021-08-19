#!/bin/sh

mkdir build
cd build

ls $SP_DIR

cmake ${CMAKE_ARGS} .. \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_PYTHON_INTERFACE=ON \
      -DPYTHON_EXECUTABLE=$PYTHON \
      -DBUILD_TESTING=OFF

make -j${CPU_COUNT}
make install
