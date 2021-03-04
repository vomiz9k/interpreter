#pragma once

#include <base.hpp>

class Expr;

class Expressions: public Base
{
    virtual void accept(Visitor* visitor);
};

class Empty_Expressions: public Expressions
{
public:

    Empty_Expressions();
    void accept(Visitor* visitor) override;
};

class Single_Expressions: public Expressions
{
    Expr* expr;
 public:

    Single_Expressions(Expr* expr);
    void accept(Visitor* visitor) override;    
};


class Multiple_expressions;

class Many_Expressions: public Expressions
{
    Expr* expr;
    Multiple_expressions* prev_exprs;
public:
    Many_Expressions(Multiple_expressions* prev_exprs, Expr* expr);
    void accept(Visitor* visitor) override;    
};

class Multiple_expressions: public Base //other rule
{
    virtual void accept(Visitor* visitor);
};

class Single_Multiple_expressions: public Multiple_expressions
{
    Expr* expr;
public:
    Single_Multiple_expressions(Expr* expr);
    void accept(Visitor* visitor) override;  
};

class Many_Multiple_expressions: public Multiple_expressions
{
    Multiple_expressions* prev_exprs;
    Expr* expr;
public:
    Many_Multiple_expressions(Multiple_expressions* prev_exprs, Expr* expr);
    void accept(Visitor* visitor) override;  
};

