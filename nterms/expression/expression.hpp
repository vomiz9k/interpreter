#pragma once

#include <base.hpp>
#include <string>


class Expr: public Base
{
    virtual void accept(Visitor* visitor);
};

class Value;    
class Value_Expr: public Expr
{
    Value* value;
public:
    Value_Expr(Value* value);
    void accept(Visitor* visitor) override;
};

class Id_Expr: public Expr
{
    std::string* name;
public:
    Id_Expr(std::string* name);
    void accept(Visitor* visitor) override;
};

class Array_el_Expr: public Expr
{
    Expr* array;
    Expr* index;
public:
    Array_el_Expr(Expr* array, Expr* index);
    void accept(Visitor* visitor) override;
};

class Length_Expr: public Expr
{
    Expr* array;
public:
    Length_Expr(Expr* array);
    void accept(Visitor* visitor) override;
};

class Field_invocation;
class Field_invocation_Expr: public Expr
{
    Field_invocation* invocation;
public:
    Field_invocation_Expr(Field_invocation* invocation);
    void accept(Visitor* visitor) override;
};

class Not_Expr: public Expr
{
    Expr* expr;
public:
    Not_Expr(Expr* expr);
    void accept(Visitor* visitor) override;
};

class This_Expr: public Expr
{
public:
    This_Expr();
    void accept(Visitor* visitor) override;
};

class Method_invocation;
class Method_invocation_Expr: public Expr
{
    Method_invocation* invocation;
public:
    Method_invocation_Expr(Method_invocation* invocation);
    void accept(Visitor* visitor) override;
};

class Plus_Expr: public Expr
{   
    Expr* first;
    Expr* second;
public:
    Plus_Expr(Expr* first, Expr* second);

    void accept(Visitor* visitor) override;
};

class Minus_Expr: public Expr
{   
    Expr* first;
    Expr* second;
public:
    Minus_Expr(Expr* first, Expr* second);

    void accept(Visitor* visitor) override;
};

class Star_Expr: public Expr
{   
    Expr* first;
    Expr* second;
public:
    Star_Expr(Expr* first, Expr* second);

    void accept(Visitor* visitor) override;
};

class Slash_Expr: public Expr
{   
    Expr* first;
    Expr* second;
public:
    Slash_Expr(Expr* first, Expr* second);

    void accept(Visitor* visitor) override;
};

class Percent_Expr: public Expr
{   
    Expr* first;
    Expr* second;
public:
    Percent_Expr(Expr* first, Expr* second);

    void accept(Visitor* visitor) override;
};

class And_Expr: public Expr
{   
    Expr* first;
    Expr* second;
public:
    And_Expr(Expr* first, Expr* second);

    void accept(Visitor* visitor) override;
};

class Or_Expr: public Expr
{   
    Expr* first;
    Expr* second;
public:
    Or_Expr(Expr* first, Expr* second);

    void accept(Visitor* visitor) override;
};

class Smaller_Expr: public Expr
{   
    Expr* first;
    Expr* second;
public:
    Smaller_Expr(Expr* first, Expr* second);

    void accept(Visitor* visitor) override;
};

class Bigger_Expr: public Expr
{   
    Expr* first;
    Expr* second;
public:
    Bigger_Expr(Expr* first, Expr* second);

    void accept(Visitor* visitor) override;
};

class Equal_Expr: public Expr
{   
    Expr* first;
    Expr* second;
public:
    Equal_Expr(Expr* first, Expr* second);

    void accept(Visitor* visitor) override;
};

class Not_equal_Expr: public Expr
{   
    Expr* first;
    Expr* second;
public:
    Not_equal_Expr(Expr* first, Expr* second);

    void accept(Visitor* visitor) override;
};


class Brackets_Expr:public Expr
{
    Expr* expr;
public:
    Brackets_Expr(Expr* expr);
    void accept(Visitor* visitor) override;
};


