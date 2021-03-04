#pragma once

#include <string>
#include <base.hpp>

class Type;
class Method_args;
class Statements;

class Method_declaration: public Base
{
    Type* type;
    std::string* name;
    Method_args* args;
    Statements* statements;
public:

    Method_declaration (Type* type,
                        std::string* name,
                        Method_args* args,
                        Statements* statements);
                        
    void accept(Visitor* visitor) override;
};