cmake_minimum_required(VERSION 3.10)

project(MyProject CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Werror")

include(CTest)

option(BUILD_EXAMPLES "Build the examples" ON)
option(BUILD_TESTS "Build the tests" ON)
option(TIDY "Run clang-tidy checks by default" ON)
option(FORMAT "Create the format target" ON)

# Set binaries output dir
set(CMAKE_BINARY_DIR ${CMAKE_BINARY_DIR}/bin)
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR})
set(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR})

add_compile_options(-fstack-protector-strong)

set(CMAKE_SHARED_LINKER_FLAGS "-Wl,-rpath=$ORIGIN -Wl,--no-undefined")

add_subdirectory(src)

if (BUILD_EXAMPLES)
  add_subdirectory(examples)
endif()

if (BUILD_TESTS)
  add_subdirectory(tests)
endif()

# Enable clang-tidy of source files
if (TIDY)
  find_program(CLANG_TIDY_EXE
    NAMES clang-tidy-12
    REQUIRED)
  if (NOT CLANG_TIDY_EXE)
    message(FATAL_ERROR "Please install clang-tidy-12.")
  endif()
  set(CMAKE_CXX_CLANG_TIDY "${CLANG_TIDY_EXE};--header-filter=.*")
endif()

# Add the format build target
if (FORMAT)
  file(GLOB_RECURSE ALL_SOURCE_FILES *.cpp *.h)
  list(FILTER ALL_SOURCE_FILES EXCLUDE REGEX "/build/CMakeFiles/*")
  add_custom_target(
    format
    COMMAND clang-format
    -i
    -verbose
    ${ALL_SOURCE_FILES})
endif()
