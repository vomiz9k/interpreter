#pragma once

#include <base.hpp>
#include <string>

class Statements;

class Type: public Base
{
public:
    virtual void accept(Visitor* visitor);
};

class Simple_Type: public Type
{
    std::string* name;
public:
    Simple_Type(std::string* name);
    void accept(Visitor* visitor) override;
};

class Array_Type: public Type
{
    std::string* name;
public:
    Array_Type(std::string* name);
    void accept(Visitor* visitor) override;
};