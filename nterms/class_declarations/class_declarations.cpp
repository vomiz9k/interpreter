#include <class_declarations.hpp>

Empty_Class_declarations::Empty_Class_declarations()
{

}
    
void Empty_Class_declarations::accept(Visitor* visitor)
{
    visitor->visit(this);
}



Not_Empty_Class_declarations::Not_Empty_Class_declarations(Class_declarations* next_class_decls, Class_declaration* class_decl)
    :next_class_decls(next_class_decls), class_decl(class_decl)
{

}

void  Not_Empty_Class_declarations::accept(Visitor* visitor)
{
    visitor->visit(this);
}
