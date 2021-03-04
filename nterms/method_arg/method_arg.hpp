#pragma once

#include <string>
#include <base.hpp>

class Type;

class Method_arg: public Base
{        
    Type* type;
    std::string* name;
public:
    Method_arg(Type* type, std::string* name);
    void accept(Visitor* visitor) override;
};
