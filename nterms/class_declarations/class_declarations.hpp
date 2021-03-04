#pragma once

#include <string>
#include <base.hpp>

class Class_declaration;

class Class_declarations: public Base
{
public:
    virtual void accept(Visitor* visitor);
};

class Empty_Class_declarations: public Class_declarations
{
public:
    Empty_Class_declarations();
    void accept(Visitor* visitor);
};

class Not_Empty_Class_declarations: public Class_declarations
{
    Class_declarations* next_class_decls;
    Class_declaration* class_decl;
public:
    Not_Empty_Class_declarations(Class_declarations* next_class_decls, Class_declaration* class_decl);
    void accept(Visitor* visitor);
};