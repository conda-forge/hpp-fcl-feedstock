#!/bin/sh

mkdir build
cd build

export BUILD_NUMPY_INCLUDE_DIRS=$( $PYTHON -c "import numpy; print (numpy.get_include())")
export TARGET_NUMPY_INCLUDE_DIRS=$SP_DIR/numpy/core/include

echo $BUILD_NUMPY_INCLUDE_DIRS
echo $TARGET_NUMPY_INCLUDE_DIRS

if [[ $CONDA_BUILD_CROSS_COMPILATION == 1 ]]; then
  echo "Copying files from $BUILD_NUMPY_INCLUDE_DIRS to $TARGET_NUMPY_INCLUDE_DIRS"
  mkdir -p $TARGET_NUMPY_INCLUDE_DIRS
  cp -r $BUILD_NUMPY_INCLUDE_DIRS/numpy $TARGET_NUMPY_INCLUDE_DIRS
  export Python3_NumPy_INCLUDE_DIR=$TARGET_NUMPY_INCLUDE_DIRS
else
  export Python3_NumPy_INCLUDE_DIR=$BUILD_NUMPY_INCLUDE_DIRS
fi

cmake ${CMAKE_ARGS} .. \
      -GNinja \
      -DCMAKE_BUILD_TYPE=Release \
      -DPYTHON_EXECUTABLE=$PYTHON \
      -DGENERATE_PYTHON_STUBS=OFF \
      -DPython3_NumPy_INCLUDE_DIR=$Python3_NumPy_INCLUDE_DIR \
      -DHPP_FCL_HAS_QHULL=ON \
      -DCMAKE_CXX_STANDARD=11 \
      -DBUILD_PYTHON_INTERFACE=ON \
      -DBUILD_TESTING=OFF \
      -DCOAL_BACKWARD_COMPATIBILITY_WITH_HPP_FCL=ON

ninja install-hpp-fcl-compatibility
