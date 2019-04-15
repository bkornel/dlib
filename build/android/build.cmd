@echo off

cd C:\code\dlib\build\android

rem ANDROID_SDK must be something like 'C:\Users\kbertok\AppData\Local\Android\Sdk'
echo "- ANDROID_SDK: %ANDROID_SDK%"

rem can be also: 'x86', 'x86_64', 'armeabi', 'armeabi-v7a', 'arm64-v8a'
set abi="armeabi-v7a"

set build_dir="builds/abi-%abi%"
set install_dir="CMAKE_INSTALL_PREFIX=install/abi-%abi%"
set makefile="MinGW Makefiles"
set make_program="CMAKE_MAKE_PROGRAM=%ANDROID_SDK%\ndk-bundle\prebuilt\windows-x86_64\bin\make.exe"
set toolchain="CMAKE_TOOLCHAIN_FILE=%ANDROID_SDK%\ndk-bundle\build\cmake\android.toolchain.cmake"
set android_abi="ANDROID_ABI=%abi%"
set android_stl="ANDROID_STL=c++_static"
set build_type="CMAKE_BUILD_TYPE=Release"
set api_level="ANDROID_NATIVE_API_LEVEL=android-27"
set arm_neon="ANDROID_ARM_NEON=TRUE"
set cpp_features="ANDROID_CPP_FEATURES=rtti exceptions"

rem generating the make files
cmake -HDlib -B%build_dir% -G%makefile% -D%make_program% -D%toolchain% -D%android_abi% -D%android_stl% -D%build_type% -D%api_level% -D%arm_neon% -D%cpp_features% -D%install_dir% ../../

rem cross compilation and installation dlib for android
cmake --build %build_dir% --target install

pause
