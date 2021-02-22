#pragma once
#include <string>
#include <map>
#include <fstream>

#include "lexer.hpp"
#include "bison.hpp"


class Driver {
 public:
    Driver();

    std::map<std::string, int> variables;

    int parse(const std::string& filename);

    friend class Lexer;
    
    Lexer lexer;
    yy::parser bison;

};
