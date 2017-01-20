BINARYDIR := Debug

AZUREROOT := /opt/test/azure-iot-sdks/c
TOOLCHAINROOT := /opt/env/freescale/usr/local/gcc-4.1.2-glibc-2.5-nptl-3/arm-none-linux-gnueabi

#Toolchain
CC := $(TOOLCHAINROOT)/bin/arm-none-linux-gnueabi-gcc
CXX := $(TOOLCHAINROOT)/bin/arm-none-linux-gnueabi-g++
LD := $(CXX)
AR := $(TOOLCHAINROOT)/bin/arm-none-linux-gnueabi-ar
OBJCOPY := $(TOOLCHAINROOT)/bin/arm-none-linux-gnueabi-objcopy

#Additional flags
PREPROCESSOR_MACROS := 
INCLUDE_DIRS := $(AZUREROOT)/azure-c-shared-utility/inc $(AZUREROOT)/azure-umqtt-c/inc $(AZUREROOT)/serializer/inc $(AZUREROOT)/iothub_client/inc $(AZUREROOT) $(TOOLCHAINROOT)/arm-none-linux-gnueabi/sysroot/usr/include $(AZUREROOT)/sample/openssl/include
LIBRARY_DIRS := $(AZUREROOT)/sample/openssl/lib $(TOOLCHAINROOT)/arm-none-linux-gnueabi/sysroot/lib
LIBRARY_NAMES := ssl crypto
ADDITIONAL_LINKER_INPUTS := -lpthread
MACOS_FRAMEWORKS := 
LINUX_PACKAGES := 

CFLAGS := -ggdb -ffunction-sections -O0 -std=gnu99 -pthread
CXXFLAGS := -ggdb -ffunction-sections -O0 -std=gnu99 -pthread
ASFLAGS := 
LDFLAGS := 
COMMONFLAGS := 

START_GROUP := -Wl,--start-group
END_GROUP := -Wl,--end-group

#Additional options detected from testing the toolchain
IS_LINUX_PROJECT := 1
