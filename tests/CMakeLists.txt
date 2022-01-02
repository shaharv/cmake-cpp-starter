cmake_minimum_required(VERSION 3.10)

add_executable(example_test example_test.cpp)
target_include_directories(example_test PUBLIC ../include)
add_test(NAME example_test COMMAND $<TARGET_FILE:example_test>)
