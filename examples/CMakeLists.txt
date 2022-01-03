cmake_minimum_required(VERSION 3.10)

add_executable(example_exe ${CMAKE_CURRENT_SOURCE_DIR}/example.cpp)
target_include_directories(example_exe
  PRIVATE
  ${PROJECT_SOURCE_DIR}/include
  ${PROJECT_SOURCE_DIR}/src)
target_link_libraries(example_exe MySharedLib)
