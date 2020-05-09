cmake_minimum_required(VERSION 3.10)

add_library(MyProject
  my_project.cpp)

target_include_directories(MyProject
  PUBLIC
  ${CMAKE_CURRENT_BINARY_DIR}/../include)
