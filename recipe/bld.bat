set PKG_CONFIG_PATH=%LIBRARY_PREFIX%\share\pkgconfig

mkdir build
cd build

set "CC=clang-cl.exe"
set "CXX=clang-cl.exe"

cmake ^
    -G "NMake Makefiles" ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DHPP_FCL_SITELIB_ROOT=%PREFIX% ^
    -DPYTHON_EXECUTABLE=%PYTHON% ^
    -DBUILD_PYTHON_INTERFACE=ON ^
    -DBUILD_TESTING=OFF ^
    %SRC_DIR%
if errorlevel 1 exit 1

:: Build.
cmake --build . --config Release
if errorlevel 1 exit 1

:: Install.
cmake --build . --config Release --target install
if errorlevel 1 exit 1
