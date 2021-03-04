#pragma once
#include <string>
#include <map>
#include <fstream>

#include <bison.hpp>
#include <lexer.hpp>



class Driver {
 public:
    Driver();

    std::map<std::string, int> variables;

    int parse(const std::string& filename);

    friend class Lexer;
    
    Lexer lexer;
    yy::parser bison;
};
