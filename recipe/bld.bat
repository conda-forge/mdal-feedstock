mkdir build
if errorlevel 1 exit /b 1

cd build
if errorlevel 1 exit /b 1

cmake  ^
	-G "Visual Studio 16 2019" ^
	-DCMAKE_BUILD_TYPE=Release  ^
	-DENABLE_TESTS=on ^
	-DNETCDF_PREFIX="%LIBRARY_PREFIX%" ^
	-DHDF5_ROOT="%LIBRARY_PREFIX%" ^
	-DGDAL_DIR="%LIBRARY_PREFIX%" ^
	-DGDAL_LIBRARY="%LIBRARY_PREFIX%\lib\gdal.lib" ^
	-DGDAL_INCLUDE_DIR="%LIBRARY_PREFIX%\include" ^
	-DLIBXML2_LIBRARIES="%LIBRARY_PREFIX%\lib\libxml2.lib" ^
	-DLIBXML2_INCLUDE_DIR="%LIBRARY_PREFIX%\include\libxml2" ^
	-DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%" ^
	-DCMAKE_INCLUDE_PATH="%INCLUDE_INC%" ^
	-D EXTERNAL_DRIVER_DHI_DFS=OFF ^
	..
if errorlevel 1 exit /b 1

cmake --build . --config Release
if errorlevel 1 exit /b 1

set PATH=%PATH%;%LIBRARY_BIN%

copy /B mdal\Release\*.dll %LIBRARY_BIN%
if errorlevel 1 exit /b 1

copy /B mdal\Release\*.lib %LIBRARY_LIB%
if errorlevel 1 exit /b 1

copy /B tools\Release\*.exe %LIBRARY_BIN%
if errorlevel 1 exit /b 1

ctest --version

set GRIB_ADJUST_LONGITUDE_RANGE=NO

ctest -VV -C Release --exclude-regex "mdal_dynamic*|mdal_api*|mdal_gdal_netcdf*|mdal_ugrid*"
if errorlevel 1 exit /b 1

cd ..

copy mdal\api\mdal.h %LIBRARY_INC%
if errorlevel 1 exit /b 1
