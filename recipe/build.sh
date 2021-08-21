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
fi

cmake ${CMAKE_ARGS} .. \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_PYTHON_INTERFACE=ON \
      -DPYTHON_EXECUTABLE=$PYTHON \
      -DBUILD_TESTING=OFF

make -j${CPU_COUNT}
make install

if [[ $CONDA_BUILD_CROSS_COMPILATION == 1 ]]; then
  echo $BUILD_PREFIX
  echo $PREFIX
  sed -i.back 's|'"$BUILD_PREFIX"'|'"$PREFIX"'|g' $PREFIX/lib/cmake/eigenpy/eigenpyTargets.cmake
  rm $PREFIX/lib/cmake/eigenpy/eigenpyTargets.cmake.back
fi
