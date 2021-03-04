#pragma once

//#include <visitor.hpp>

class Base;

class Visitor
{
public:
    virtual void visit(Base* base);
};

class Base
{
    
public:
    virtual void accept(Visitor* visitor);
};