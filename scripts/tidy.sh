#!/bin/bash -eu

function init {
    SCRIPT_DIR=`dirname $0`
    cd $SCRIPT_DIR
    SCRIPT_DIR=`pwd`

    BUILD_FLAGS="-fPIC"
    INCLUDES="-I$SCRIPT_DIR/../include -I$SCRIPT_DIR/../src"
    WARN_FLAGS="-Wall -Werror -Wextra"

    CPP_UNITY_FILE=../build/ALL.cpp
    CPP_FLAGS="$BUILD_FLAGS $INCLUDES $WARN_FLAGS"
}

function build_unity_file {
    find $SCRIPT_DIR/../src $SCRIPT_DIR/../examples -name '*.cpp' -or -name '*.h' | \
        sed 's/^/#include "/' | sed 's+$+" // NOLINT+' | sort > $CPP_UNITY_FILE

    # Support running examples (stand alone executables) with clang-tidy as standalone..
    # Each example has a main function, so we need to give each a unique name (just
    # for passing compilation in the unity file). Each main is replaced with "main_N"
    # where N is the line number.
    # - cat -n prints the line number before each line of ALL.cpp
    # - 1st sed adds "#undef main ... #define main main_N" before each example.cpp
    # - 2nd sed removes the remaining line numbers
    # - 3rd sed removes remaining whitespace.
    TEMP_FILE=$CPP_UNITY_FILE.tmp
    cat -n $CPP_UNITY_FILE |
        sed 's/^\([[:space:]]\+\)\([[:digit:]]\+\)\(.*examples.*\.cpp\)/#undef main\n#define main main_\2\n\3/g' |
        sed 's/^[[:space:]]\+[[:digit:]]\+//g' |
        sed 's/^[ \t]*//g' > $TEMP_FILE
    mv $TEMP_FILE $CPP_UNITY_FILE
}

function run_compile {
    COMPILE_CMD=`echo "g++ $CPP_UNITY_FILE $CPP_FLAGS -c -o $CPP_UNITY_FILE.o" | sed 's/  */ /g'`
    echo "Running g++:"
    echo $COMPILE_CMD
    $COMPILE_CMD
}

function run_tidy {
    TIDY_CMD=`echo "clang-tidy-18 --config-file=$SCRIPT_DIR/../.clang-tidy $CPP_UNITY_FILE -- $CPP_FLAGS" | sed 's/  */ /g'`
    echo "Running clang-tidy:"
    echo $TIDY_CMD
    $TIDY_CMD
}

function main {
    init
    build_unity_file
    run_compile
    echo
    run_tidy
}

main
