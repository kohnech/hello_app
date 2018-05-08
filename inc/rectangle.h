#pragma once


class Rectangle
{
    int width, height;
public:
    void set_values (int width, int height);
    int area()
    {
        return width * height;
    }
};