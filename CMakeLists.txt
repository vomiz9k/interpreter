cmake_minimum_required(VERSION 3.16)

project(ParserExample)
set(
    HEADERS
    ${ParserExample_SOURCE_DIR}/driver.hpp
    ${ParserExample_SOURCE_DIR}/bison.hpp
    )

find_package(FLEX REQUIRED)
find_package(BISON REQUIRED)

BISON_TARGET(
    MyParser
    bison.y
    ${ParserExample_SOURCE_DIR}/bison.cpp
    COMPILE_FLAGS --graph
    DEFINES_FILE ${ParserExample_SOURCE_DIR}/bison.hpp
)

FLEX_TARGET(
    MyScanner
    lexer.l
    ${ParserExample_SOURCE_DIR}/lexer.cpp
)

ADD_FLEX_BISON_DEPENDENCY(MyScanner MyParser)

add_executable(
    02-ParserExample
    main.cpp
    driver.cpp
    ${BISON_MyParser_OUTPUTS}
    ${FLEX_MyScanner_OUTPUTS}
)
target_include_directories(02-ParserExample PRIVATE ${ParserExample_SOURCE_DIR})



