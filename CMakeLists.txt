cmake_minimum_required(VERSION 3.10)

project(MyProject CXX)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Werror")

enable_testing()

option(BUILD_TESTS "Build the tests" ON)
add_subdirectory(lib)

if (BUILD_TESTS)
  add_subdirectory(tests)
endif()
