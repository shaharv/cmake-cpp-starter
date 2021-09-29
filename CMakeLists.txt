cmake_minimum_required(VERSION 3.10)

project(MyProject CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Werror")

include(CTest)

option(BUILD_EXAMPLES "Build the examples" ON)
option(BUILD_TESTS "Build the tests" ON)
option(CLANG_TIDY_CHECKS "Run clang-tidy checks by default" ON)
option(FORMAT_TARGET "Create the format target" ON)

if (CLANG_TIDY_CHECKS)
  set(CMAKE_CXX_CLANG_TIDY "clang-tidy;--header-filter=.*")
endif()

add_subdirectory(lib)

if (BUILD_EXAMPLES)
  add_subdirectory(examples)
endif()

if (BUILD_TESTS)
  add_subdirectory(tests)
endif()

if (FORMAT_TARGET)
  file(GLOB_RECURSE ALL_SOURCE_FILES *.cpp *.h)
  list(FILTER ALL_SOURCE_FILES EXCLUDE REGEX "/build/CMakeFiles/*")
  add_custom_target(
    format
    COMMAND clang-format
    -i
    -verbose
    ${ALL_SOURCE_FILES}
  )
endif()
