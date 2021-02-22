%skeleton "lalr1.cc"
%require "3.5"

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

    /* Redefine parser to use our function from scanner */
    static yy::parser::symbol_type yylex(Lexer &lexer) {
        return lexer.ScanToken();
    }
}



%lex-param { Lexer &lexer }

%parse-param { Lexer& lexer }
%parse-param { Driver &driver }

%token
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
    MAIN "Main"
    INT "int"
    BOOL "bool"
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

%token <std::string> IDENTIFIER "id"
%token <int> NUMBER "num"
%nterm <int> expr


%%
%left "+" "-";
%left "*" "/" "%";

%start program;

program: main_class   {};

main_class: "class" "Main" "{" "public static void main" "(" ")" "{" global_body "}" "}"  {};

global_body:   
    %empty {} 
    | global_statement global_body {};

global_statement: 
    variable_declaration {}
    | variable_assignment {}
    | "if" "(" expr ")" "{" local_body "}" {}
    | "if" "(" expr ")" "{" local_body "}" "else" "{" local_body "}" {}
    | "while" "(" expr ")" "{" local_body "}" {}
    | "System.out.println" "(" expr ")" ";" {std::cout << $3 ;};

variable_declaration:
    type "id" ";" {
        driver.variables[$2] = 0;
    };

type:  "int" {};

variable_assignment:
    "id" "=" expr ";" {
        if(driver.variables.count($1))
        {
            driver.variables[$1] = $3;
        }
        else
        {
            std::cout << "SE";
        }
    
    };

local_body:
    %empty {}
    | local_statement local_body {};

local_statement: 
    variable_assignment {}
    | "System.out.println" "(" expr ")" ";" {std::cout << $3 ;};

expr: 
    "num" {
        $$ = $1;
    }
    | "id" {
        if(driver.variables.count($1))
        {
            $$ = driver.variables[$1];
        }
        else
        {
            std::cout << "SE";
        }
    }
    | expr "+" expr { 
        $$ = $1 + $3;
    }
    | expr "-" expr { 
        $$ = $1 - $3;
    }
    | expr "*" expr { 
        $$ = $1 * $3;
    }
    | expr "/" expr { 
        $$ = $1 / $3;
    }
    | expr "%" expr { 
        $$ = $1 % $3;
    }
    | "(" expr ")" { 
        $$ = $2;
    };

%%

void yy::parser::error(const std::string& m)
{
  std::cerr << 1 << ": " << m << '\n';
}
