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
    PSVM "public static void main"
    CLASS "class"
    INT "int"
    BOOL "bool"
    VOID "void"
    LFBRACKET "{"
    RFBRACKET "}"
    IF "if"
    ELSE "else"
    WHILE "while"
    SOP "System.out.println"
    EQUAL "=="
    NOT_EQUAL "!="
    BIGGER ">"
    SMALLER "<"
;

%token <std::string> identifier "id"
%token <int> number "num"
%nterm <int> expr
%nterm <std::string> type


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
    | simple_type "[" "]" {};

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
    expr "." expr {};

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
    | expr "[" expr "]" {}
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

%%

void yy::parser::error(const std::string& str)
{
    std::cerr << "Syntax Error: " << str << '\n';
}


