cmake_minimum_required(VERSION 3.8)
project(bool)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_FLAGS "-Wdeprecated-register -Wwritable-strings")

find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)

bison_target(bool bool.y ${CMAKE_CURRENT_BINARY_DIR}/bool.cpp
        DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/y.tab.h)
flex_target(scan scan.l ${CMAKE_CURRENT_BINARY_DIR}/scan.cpp)

ADD_FLEX_BISON_DEPENDENCY(scan bool)


include_directories(${CMAKE_CURRENT_BINARY_DIR})
add_executable(bool ${FLEX_scan_OUTPUTS} ${BISON_bool_OUTPUTS})

if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    set(FLEX_LIBRARIES /usr/local/opt/flex/lib/libfl.a)
endif()
target_link_libraries(bool ${FLEX_LIBRARIES})