# copyright 2018 by Charl P. Botha <cpbotha@vxlabs.com>

SET(CMAKE_SYSTEM_NAME Generic)
SET(CMAKE_SYSTEM_VERSION 1)

# on Linux, this should be: $ENV{HOME}/.arduino15/packages
SET(ARDUINO_PACKAGES $ENV{HOME}/Library/Arduino15/packages)
# on Linux, this will be WHERE_YOU_UNPACKED/arduino
SET(ARDUINO_CMD /Applications/Arduino.app/Contents/MacOS/Arduino)

# specify the cross compiler
set(CMAKE_C_COMPILER ${ARDUINO_PACKAGES}/arduino/tools/arm-none-eabi-gcc/4.8.3-2014q1/bin/arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER ${ARDUINO_PACKAGES}/arduino/tools/arm-none-eabi-gcc/4.8.3-2014q1/bin/arm-none-eabi-g++)

# use arduino --verify --verbose command, then wait for FINAL cpp compilation to extract these arguments, the include
# directories below this, and the definitions below that.
# hint: look in the output for "Compiling sketch..."
SET(COMMON_FLAGS "-mcpu=cortex-m0plus -mthumb -c -g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -MMD")
SET(CMAKE_CXX_FLAGS "${COMMON_FLAGS} -fno-threadsafe-statics -fno-rtti -fno-exceptions")
SET(CMAKE_C_FLAGS "${COMMON_FLAGS}")
# https://stackoverflow.com/questions/19419782/exit-c-text0x18-undefined-reference-to-exit-when-using-arm-none-eabi-gcc
# https://github.com/vpetrigo/arm-cmake-toolchains/blob/master/arm-gcc-toolchain.cmake
SET(CMAKE_EXE_LINKER_FLAGS_INIT "-specs=nosys.specs")
SET(CMAKE_EXE_LINKER_FLAGS "-specs=nosys.specs")

# BLOODY HELL it's all because it's an ino file and not a cpp ARGH ARGH ARGH don't be so primitve!
# http://docs.platformio.org/en/latest/faq.html#convert-arduino-file-to-c-manually
# (clion ignores all of these if include directories you try to keep your code in the .ino file,
#  that's why we move it out to cpp!)
include_directories(
        ${ARDUINO_PACKAGES}/arduino/tools/CMSIS/4.5.0/CMSIS/Include/
        ${ARDUINO_PACKAGES}/arduino/tools/CMSIS-Atmel/1.1.0/CMSIS/Device/ATMEL/
        ${ARDUINO_PACKAGES}/arduino/hardware/samd/1.6.18/cores/arduino/
        ${ARDUINO_PACKAGES}/arduino/hardware/samd/1.6.18/variants/arduino_mzero/
        ${ARDUINO_PACKAGES}/arduino/tools/arm-none-eabi-gcc/4.8.3-2014q1/arm-none-eabi/include/
)

add_definitions(
        -DF_CPU=48000000L
        -DARDUINO=10805
        -DARDUINO_SAM_ZERO
        -DARDUINO_ARCH_SAMD
        -D__SAMD21G18A__
        -DUSB_VID=0x2a03
        -DUSB_PID=0x804e
        -DUSBCON
        -DUSB_MANUFACTURER="Unknown"
        -DUSB_PRODUCT="Arduino M0"
)
