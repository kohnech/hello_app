
#include <iostream>

#include "hello.h"


void Hello::printMessage(void)
{
    std::cout << "hello!" << std::endl;
}

void Hello::readMessage(void)
{
}

unsigned long long Hello::factorial(uint32_t n)
{
    unsigned long long factorial = 1;
    for(int i = 1; i <= n; ++i)
    {
        factorial *= i;
    }
    return factorial;
}