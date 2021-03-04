#pragma once

#include <base.hpp>

class Main_class;
class Class_declarations;

class Program: public Base
{
    Main_class* main_class;
    Class_declarations* class_declarations;

public:
    Program(Main_class* main_class, Class_declarations* class_declarations);
    void accept(Visitor* visitor) override;
};
