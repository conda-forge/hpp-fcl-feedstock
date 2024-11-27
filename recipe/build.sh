#!/bin/sh

mkdir build
cd build

export Python3_NumPy_INCLUDE_DIR=$( $PYTHON -c "import numpy; print (numpy.get_include())")

cmake ${CMAKE_ARGS} .. \
      -GNinja \
      -DCMAKE_BUILD_TYPE=Release \
      -DPYTHON_EXECUTABLE=$PYTHON \
      -DPYTHON_SITELIB=$PREFIX/site-packages \
      -DGENERATE_PYTHON_STUBS=OFF \
      -DPython3_NumPy_INCLUDE_DIR=$Python3_NumPy_INCLUDE_DIR \
      -DBUILD_PYTHON_INTERFACE=ON \
      -DBUILD_TESTING=OFF \
      -DENABLE_PYTHON_DOXYGEN_AUTODOC=OFF \
      -DCOAL_BACKWARD_COMPATIBILITY_WITH_HPP_FCL=ON

ninja install-hpp-fcl-compatibility
