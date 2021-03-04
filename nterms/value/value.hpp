#pragma once

#include <base.hpp>

class Value: public Base
{
    virtual void accept(Visitor* visitor);
};

class Number_Value: public Value
{
    int value;
public:
    Number_Value(int value);
    void accept(Visitor* visitor) override;
};

class TF_Value: public Value
{
    bool value;
public:
    TF_Value(bool value);
    void accept(Visitor* visitor) override;
};