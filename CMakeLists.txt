cmake_minimum_required(VERSION 3.16)

project(Compiler)
set(
    HEADERS
    ${Compiler_SOURCE_DIR}/driver/driver.hpp
    ${Compiler_SOURCE_DIR}/bison/bison.hpp
    ${Compiler_SOURCE_DIR}/lexer/lexer.hpp
    ${Compiler_SOURCE_DIR}/nterms/big_include.hpp
    ${Compiler_SOURCE_DIR}/nterms/base/base.hpp
    )

find_package(FLEX REQUIRED)
find_package(BISON REQUIRED)

BISON_TARGET(
    MyParser
    ${Compiler_SOURCE_DIR}/bison/bison.y
    ${Compiler_SOURCE_DIR}/bison/bison.cpp

    DEFINES_FILE ${Compiler_SOURCE_DIR}/bison/bison.hpp
)

FLEX_TARGET(
    MyScanner
    ${Compiler_SOURCE_DIR}/lexer/lexer.l
    ${Compiler_SOURCE_DIR}/lexer/lexer.cpp
)

ADD_FLEX_BISON_DEPENDENCY(MyScanner MyParser)

add_executable(
    Compiler
    main.cpp
    ${Compiler_SOURCE_DIR}/driver/driver.cpp
    ${BISON_MyParser_OUTPUTS}
    ${FLEX_MyScanner_OUTPUTS}

    ${Compiler_SOURCE_DIR}/nterms/assignment/assignment.cpp
    ${Compiler_SOURCE_DIR}/nterms/class_declarations/class_declarations.cpp
    ${Compiler_SOURCE_DIR}/nterms/class_declaration/class_declaration.cpp
    ${Compiler_SOURCE_DIR}/nterms/declarations/declarations.cpp
    ${Compiler_SOURCE_DIR}/nterms/expression/expression.cpp
    ${Compiler_SOURCE_DIR}/nterms/expressions/expressions.cpp
    ${Compiler_SOURCE_DIR}/nterms/field_invocation/field_invocation.cpp
    ${Compiler_SOURCE_DIR}/nterms/main_class/main_class.cpp
    ${Compiler_SOURCE_DIR}/nterms/method_arg/method_arg.cpp
    ${Compiler_SOURCE_DIR}/nterms/method_args/method_args.cpp
    ${Compiler_SOURCE_DIR}/nterms/method_declaration/method_declaration.cpp
    ${Compiler_SOURCE_DIR}/nterms/method_invocation/method_invocation.cpp
    ${Compiler_SOURCE_DIR}/nterms/program/program.cpp
    ${Compiler_SOURCE_DIR}/nterms/statement/statement.cpp
    ${Compiler_SOURCE_DIR}/nterms/statements/statements.cpp
    ${Compiler_SOURCE_DIR}/nterms/type/type.cpp
    ${Compiler_SOURCE_DIR}/nterms/value/value.cpp
    ${Compiler_SOURCE_DIR}/nterms/variable_declaration/variable_declaration.cpp
)
target_include_directories(Compiler PUBLIC
    ${Compiler_SOURCE_DIR}/driver
    ${Compiler_SOURCE_DIR}/lexer
    ${Compiler_SOURCE_DIR}/bison
    ${Compiler_SOURCE_DIR}/nterms
    ${Compiler_SOURCE_DIR}/nterms/base
)



