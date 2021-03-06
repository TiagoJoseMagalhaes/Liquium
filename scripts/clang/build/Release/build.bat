@echo off
setlocal EnableDelayedExpansion
Rem This script compiles the project code with clang in Release mode

Rem allows this script to be called from anywhere
cd %~dp0%
:git_search_start
if not exist .git (
    cd ..
    goto :git_search_start
)

Rem checks if the build directory exists and the configured build type matches the intended build type
set cmake_config_present=0
if exist .\build\clang\build_type (
    set /p build_type=< ./build/clang/build_type
    if !build_type!==Release (
        echo build folder already configured for Release build, skipping cmake config step
        set cmake_config_present=1
    )
)
 
Rem runs the cmake scripts if either the buld file did not exists or the old build type was not Release
if %cmake_config_present%==0 (
    call ./scripts/clang/cmake.bat -DCMAKE_BUILD_TYPE=Release -DENABLE_TESTS=OFF
    if errorlevel 1 (
        echo Failed to run cmake configuration for Release build type
        exit /b %errorlevel%
    )
    if exist ./build/clang/build_type (
        del /q /f .\build\clang\build_type
        if errorlevel 1 (
           echo Failed to reset build_type file
        )
    )
    echo Release>> ./build/clang/build_type
    if errorlevel 1 (
        echo Failed to write build type to build folder, rebuld script may not work
    )
)

Rem compiles the code
cd build/clang
ninja
if errorlevel 1 (
    echo Failed to compile code
    exit /b %errorlevel%
)