#include "MyClass.h"
#include "common.h"

#include <iostream>

namespace my_project {

MyClass::MyClass() {
    std::cout << "MyClass c'tor\n";
}

MyClass::~MyClass() {
    std::cout << "MyClass d'tor\n";
}

} // namespace my_project
