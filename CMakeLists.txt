cmake_minimum_required(VERSION 3.10)

project(MyProject CXX)

set(CMAKE_CXX_STANDARD 14)

enable_testing()

add_subdirectory(lib)
add_subdirectory(tests)
