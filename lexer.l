%option noyywrap nounput noinput batch debug
%option c++
%option yyclass="Lexer"
%{
    #include <string>
    #include <string.h>
    #include <iostream>
    #include "driver.hpp"
    #include "bison.hpp"
%}



identifier     [_a-zA-Z][_a-zA-Z0-9]*
number         [0-9]+




%%

\n\r|\r\b|\n|\n     ;

"class"             {
                        return yy::parser::make_CLASS();
                    }

"public static void main" {
                        return yy::parser::make_PSVM();
                    }

"if"                {
                        return yy::parser::make_IF();
                    }

"Main"              {
                        return yy::parser::make_MAIN();
                    }

"else"              {
                        return yy::parser::make_ELSE();
                    }

"while"             {
                        return yy::parser::make_WHILE();
                    }

"System.out.println" {
                        return yy::parser::make_SOP();
                    }

"bool"              {
                        return yy::parser::make_BOOL();
                    }

"int"               {
                        return yy::parser::make_INT();
                    }

"{"                 {
                        return yy::parser::make_LFBRACKET();
                    }

"}"                 {
                        return yy::parser::make_RFBRACKET();
                    }

">"                 {
                        return yy::parser::make_BIGGER();
                    }
                
"<"                 {
                        return yy::parser::make_SMALLER();
                    }

"=="                {
                        return yy::parser::make_EQUAL();
                    }

"!="                {
                        return yy::parser::make_NOT_EQUAL();
                    }

"="                 {
                        return yy::parser::make_ASSIGN();
                    }

"+"                 {
                        return yy::parser::make_PLUS();
                    }
                
"-"                 {
                        return yy::parser::make_MINUS();
                    }

"*"                 {
                        return yy::parser::make_STAR();
                    }  

"/"                 {
                        return yy::parser::make_SLASH();
                    }

"%"                 {
                        return yy::parser::make_PERCENT();
                    }    

"("                 {
                        return yy::parser::make_LBRACKET();
                    }

")"                 {
                        return yy::parser::make_RBRACKET();
                    }  

";"                 {
                        return yy::parser::make_SEMICOLON();
                    }         
                    
{number}            {
                        return yy::parser::make_NUMBER(atoi(yytext));
                    }

{identifier}        {
                        return yy::parser::make_IDENTIFIER(yytext);
                    }



%%

