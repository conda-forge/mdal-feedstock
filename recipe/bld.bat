mkdir build
if errorlevel 1 exit /b 1

cd build
if errorlevel 1 exit /b 1

cmake  ^
	-DCMAKE_BUILD_TYPE=Release  ^
	-DENABLE_TESTS=on ^
	-DNETCDF_PREFIX="%LIBRARY_PREFIX%" ^
	-DHDF5_ROOT="%LIBRARY_PREFIX%" ^
	-DGDAL_DIR="%LIBRARY_PREFIX%" ^
	-DGDAL_LIBRARY="%LIBRARY_PREFIX%\lib\gdal_i.lib" ^
	-DGDAL_INCLUDE_DIR="%LIBRARY_PREFIX%\include" ^
	-DLIBXML2_LIBRARIES="%LIBRARY_PREFIX%\lib\libxml2.lib" ^
	-DLIBXML2_INCLUDE_DIR="%LIBRARY_PREFIX%\include\libxml2" ^
	-DCMAKE_INSTALL_PREFIX=%LIBRARY_BIN% ^
	-DCMAKE_PREFIX_PATH=%LIBRARY_BIN% ^
	-D EXTERNAL_DRIVER_DHI_DFSU=OFF ^
	..
if errorlevel 1 exit /b 1

cmake --build . --config Release
if errorlevel 1 exit /b 1

set PATH=%PATH%;%LIBRARY_BIN%
ctest -VV
