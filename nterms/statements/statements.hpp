#pragma once

#include <base.hpp>
class Statement;

class Statements: public Base
{
public:
    virtual void accept(Visitor* visitor);
};

class Empty_Statements: public Statements
{
public:
    Empty_Statements();
    void accept(Visitor* visitor) override;
};

class Not_empty_Statements: public Statements
{
    Statements* prev_statements;
    Statement* statement;
public:
    Not_empty_Statements(Statements* prev_statements, Statement* statement);
    void accept(Visitor* visitor) override;
};

