mkdir build
cd build

set "CC=clang-cl.exe"
set "CXX=clang-cl.exe"
set "CL=/MP"

cmake ^
    -GNinja ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DPYTHON_SITELIB=%SP_DIR% ^
    -DPYTHON_EXECUTABLE=%PYTHON% ^
    -DBUILD_PYTHON_INTERFACE=ON ^
    -DBUILD_TESTING=OFF ^
    -DCOAL_BACKWARD_COMPATIBILITY_WITH_HPP_FCL=ON ^
    %SRC_DIR%
if errorlevel 1 exit 1

:: Install.
ninja install-hpp-fcl-compatibility
if errorlevel 1 exit 1
