#!/bin/bash -eu

function init {
    SCRIPT_DIR=`dirname $0`
    cd $SCRIPT_DIR
    SCRIPT_DIR=`pwd`

    BUILD_FLAGS="-fPIC"
    INCLUDES="-I$SCRIPT_DIR/../include"
    WARN_FLAGS="-Wall -Werror -Wextra"

    CPP_UNITY_FILE=../build/ALL.cpp
    CPP_FLAGS="$BUILD_FLAGS $INCLUDES $WARN_FLAGS"
}

function build_unity_file {
    find $SCRIPT_DIR/../src -name '*.cpp' -or -name '*.h' | \
        sed 's/^/#include "/' | sed 's+$+" // NOLINT+' | sort > $CPP_UNITY_FILE
}

function run_compile {
    COMPILE_CMD=`echo "g++ $CPP_UNITY_FILE $CPP_FLAGS -c -o $CPP_UNITY_FILE.o" | sed 's/  */ /g'`
    echo "Running g++:"
    echo $COMPILE_CMD
    $COMPILE_CMD
}

function run_tidy {
    TIDY_CMD=`echo "clang-tidy-12 --config-file=$SCRIPT_DIR/../.clang-tidy $CPP_UNITY_FILE -- $CPP_FLAGS" | sed 's/  */ /g'`
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
