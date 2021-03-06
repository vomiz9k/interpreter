#pragma once

#include <string>
#include <base.hpp>

class Method_arg;

class Method_args: public Base
{    
public:    
    virtual void accept(Visitor* visitor);
};

class Empty_Method_args: public Method_args
{ 
public:       
    void accept(Visitor* visitor) override;
};

class Single_Method_args: public Method_args
{   
    Method_arg* arg;
public:
    Single_Method_args(Method_arg* arg);     
    void accept(Visitor* visitor) override;
};

class Method_multiple_arg;
class Many_Method_args: public Method_args
{
    Method_arg* arg;
    Method_multiple_arg* prev_args;
public:
    Many_Method_args(Method_multiple_arg* prev_args, Method_arg* arg);     
    void accept(Visitor* visitor) override;
};

class Method_multiple_arg: public Base //other rule same smysel
{   
public:
    virtual void accept(Visitor* visitor);
};

class Last_Method_multiple_arg : public Method_multiple_arg
{
    Method_arg* arg;
public:
    Last_Method_multiple_arg(Method_arg* arg);     
    void accept(Visitor* visitor) override;
};

class Many_Method_multiple_arg : public Method_multiple_arg
{
    Method_arg* arg;
    Method_multiple_arg* prev_args;
public:
    Many_Method_multiple_arg(Method_multiple_arg* prev_args, Method_arg* arg);     
    void accept(Visitor* visitor) override;
};



