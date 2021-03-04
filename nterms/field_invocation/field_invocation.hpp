#include <base.hpp>
#include <string>

class Field_invocation: public Base
{
    std::string* name;
    
public:
    Field_invocation(std::string* name);
    void accept(Visitor* visitor) override;
};