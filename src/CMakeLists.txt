cmake_minimum_required(VERSION 3.10)

set(SOURCE_FILES
  SomeClass.cpp
)

add_library(MyObjectLibrary OBJECT ${SOURCE_FILES})

target_include_directories(MyObjectLibrary
  PUBLIC
  ${CMAKE_SOURCE_DIR}/include)

set_property(TARGET MyObjectLibrary
             PROPERTY POSITION_INDEPENDENT_CODE 1)

# Build both static and shared libraries
add_library(MySharedLib SHARED $<TARGET_OBJECTS:MyObjectLibrary>)
add_library(MyStaticLib STATIC $<TARGET_OBJECTS:MyObjectLibrary>)

set_target_properties(MyStaticLib PROPERTIES OUTPUT_NAME mylib)
set_target_properties(MySharedLib PROPERTIES OUTPUT_NAME mylib)
