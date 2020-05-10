cmake_minimum_required(VERSION 3.10)

project(MyProject CXX)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Werror")

include(CTest)

option(BUILD_EXAMPLES "Build the examples" ON)
option(BUILD_TESTS "Build the tests" ON)
option(CLANG_TIDY_CHECKS "Run clang-tidy checks by default" ON)

if (CLANG_TIDY_CHECKS)
  set(CMAKE_CXX_CLANG_TIDY "clang-tidy")
endif()

add_subdirectory(lib)

if (BUILD_EXAMPLES)
  add_subdirectory(examples)
endif()

if (BUILD_TESTS)
  add_subdirectory(tests)
endif()
