cmake_minimum_required(VERSION 3.9)

project(arduino-clion-minimal)

set(CMAKE_CXX_STANDARD 11)

# add any additional library include dirs your project needs here
include_directories(
        /Users/cpbotha/Dropbox/work/code/arduino/libraries/FastLED/
)

add_executable(arduino-clion-minimal blink-main.cpp)

set_target_properties(arduino-clion-minimal PROPERTIES LINKER_LANGUAGE CXX)

# dummy target so we can build and upload sketch from clion
# make sure you have selected the correct board and port in the arduino IDE before building this target!
# see https://github.com/arduino/Arduino/blob/master/build/shared/manpage.adoc for arduino cmd options
# you can also use --board and --port arguments here. for the m0, --board arduino:samd:mzero_bl
add_custom_target(upload ALL ${ARDUINO_CMD} --upload --verbose blink.ino WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})

add_custom_target(verify ALL ${ARDUINO_CMD} --verify --verbose blink.ino WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
