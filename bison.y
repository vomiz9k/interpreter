%skeleton "lalr1.cc"
%require "3.7"

%defines
%define api.token.constructor
%define api.value.type variant
%define parse.assert

%code requires {
    #include <string>
    class Lexer;
    class Driver;
}


%define parse.trace
%define parse.error verbose


%code {

    #include "driver.hpp"

    static yy::parser::symbol_type yylex(Lexer &lexer) {
        return lexer.ScanToken();
    }

    #define SYNTAX_ERROR( str ) yy::parser::syntax_error(str)
}



%lex-param { Lexer &lexer }

%parse-param { Lexer& lexer }
%parse-param { Driver &driver }




%token
    END 0 "end of file"

    ASSIGN "="
    MINUS "-"
    PLUS "+"
    STAR "*"
    SLASH "/"
    PERCENT "%"

    SEMICOLON ";"

    LBRACKET "("
    RBRACKET ")"
    LFBRACKET "{" //Figure
    RFBRACKET "}"
    LSBRACKET "[" //Square
    RSBRACKET "]"
    ARRAY_DECL_BRACKETS "[]"

    POINT "."
    COMMA ","

    EQUAL "=="
    NOT_EQUAL "!="
    BIGGER ">"
    SMALLER "<"

    LOGIC_AND "&&"
    LOGIC_OR "||"

    CLASS "class"
    PUBLIC "public"
    STATIC "static"
    VOID  "void" 
    MAIN "main"
    EXTENDS "extends"

    INT "int"
    BOOL "bool"

    ASSERT "assert"
    RETURN "return"
    IF "if"
    ELSE "else"
    WHILE "while"
    SOP "System.out.println"
;

%nterm program
%nterm main_class
%nterm class_declarations
%nterm class_declaration
%nterm declarations
%nterm method_declaration
%nterm variable_declaration
%nterm method_args
%nterm method_multiple_arg
%nterm method_arg
%nterm type
%nterm simple_type
%nterm statements
%nterm statement
%nterm assignment
%nterm expressions
%nterm multiple_expressions

%token identifier 
%token number 
%nterm expr


%%

%left "+" "-";
%left "*" "/" "%";
%left "(";
%left "[";
%left ".";
%left "!";
%left "||";
%left "&&";
%left ">" "<" "==";
%left "=";
%left ";";

%nonassoc "then";
%nonassoc "else";

%start program;

program: 
    main_class class_declarations {};

main_class: 
    "class" identifier "{" "public" "static" "void" "main" "(" ")" "{" statements "}" "}" {};

class_declarations: 
    class_declarations class_declaration  {}
    | %empty {};

class_declaration:  
    "class" identifier "extends" identifier "{" declarations "}" {}
    | "class" identifier "{" declarations "}" {};

declarations: 
    declarations variable_declaration  {}
    | declarations method_declaration  {}
    | %empty {};

method_declaration:
    "public" type identifier "(" method_args ")" "{" statements "}" {};

variable_declaration:
    type identifier ";" {};

method_args:
    %empty {} 
    | method_arg {}
    | method_arg "," method_multiple_arg {};

method_arg:
    type identifier {};

method_multiple_arg:
    method_arg {}
    | method_multiple_arg "," method_arg{};

type:
    simple_type {}
    | simple_type "[]" {};

simple_type:
    "int" {}
    | "bool" {}
    | "void" {}
    | identifier {};

statements:   
    %empty {} 
    | statements statement  {};


statement:
    "if" "(" expr ")" statement "else" statement {}
    | "if" "(" expr ")" statement %prec "then" {}
    | "assert" "(" expr ")" {}
    | variable_declaration {}
    | "{" statements "}" {}
    | "while" "(" expr ")" statement {}
    | "System.out.println" "(" expr ")" ";" {}
    | assignment ";" {}
    | "return" expr ";" {}
    | method_invocation ";" {};


assignment:
    expr "=" expr {};

method_invocation:
    expr "." identifier "(" expressions ")" {};

field_invocation:
    "this" "." identifier {};

expressions:
    %empty {}
    | expr {}
    | expr "," multiple_expressions {};

multiple_expressions:
    expr  {}
    | multiple_expressions "," expr  {};

expr: 
    number {}
    | identifier {}
    | array_element {}
    | expr "." "length" {}
    | field_invocation {}
    | "new" simple_type "[" expr "]" {}
    | "new" identifier "(" ")" {}
    | "!" expr {}
    | "this" {}
    | "true" {}
    | "false" {}
    | method_invocation {}
    | expr "+" expr {}
    | expr "-" expr {}
    | expr "*" expr {}
    | expr "/" expr {}
    | expr "%" expr {}
    | expr "&&" expr {}
    | expr "||" expr {}
    | expr "<" expr {}
    | expr ">" expr {}
    | expr "==" expr {}
    | "(" expr ")" {};

array_element:
    identifier "[" expr "]"

%%

void yy::parser::error(const std::string& str)
{
    std::cerr << "Syntax Error: " << str << '\n';
}


