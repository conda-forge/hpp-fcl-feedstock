#!/bin/sh

mkdir build
cd build

cmake .. \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_PYTHON_INTERFACE=ON \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DPython_EXECUTABLE=$PYTHON \
      -DPYTHON_EXECUTABLE=$PYTHON

make -j${CPU_COUNT}
make install
